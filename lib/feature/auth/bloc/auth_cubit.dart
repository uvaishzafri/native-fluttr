import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/repo/firebase_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:native/repo/firestore_repository.dart';
import 'package:native/repo/user_repository.dart';
import 'package:native/util/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._firebaseRepository, this._logger, this._userRepository,
      this._firestoreRepository)
      : super(const AuthState.initial());

  final FirebaseRepository _firebaseRepository;
  final FirestoreRepository _firestoreRepository;
  final UserRepository _userRepository;
  final Logger _logger;
  late String verificationId;
  int? forceResendingToken;
  late bool isSignUp;

  void submitPhoneNumber(String phoneNumber, bool isSignUp) async {
    emit(const AuthState.loading());
    this.isSignUp = isSignUp;
    var isUserInDb = await _userRepository.checkUser(phoneNumber);
    if (isUserInDb.isLeft) {
      emit(AuthState.failed(exception: isUserInDb.left));
      return;
    } else {
      if (isSignUp && isUserInDb.right) {
        emit(AuthState.failed(exception: UserAlreadyExistException()));
        return;
      } else if (!isSignUp && !isUserInDb.right) {
        emit(AuthState.failed(exception: UserDoesNotExistException()));
        return;
      }
    }
    _firebaseRepository.submitPhoneNumber(phoneNumber, verificationCompleted,
        verificationFailed, forceResendingToken, codeSent);
    emit(const AuthState.inputPincode());
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    _logger.d("verificationCompleted");
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    _logger.d('verificationFailed : ${error.toString()}');
    emit(AuthState.failed(exception: CustomException(error.message)));
  }

  void codeSent(String verificationId, int? resendToken) {
    _logger.d("verificationId : $verificationId");
    this.verificationId = verificationId;
    forceResendingToken = resendToken;
    emit(const AuthState.inputPincode());
  }

  Future<void> inputPincode(String otpCode) async {
    emit(const AuthState.loading());
    try {
      PhoneAuthCredential credential =
          _firebaseRepository.submitOTP(otpCode, verificationId);
      await signIn(credential);
    } catch (error) {
      emit(AuthState.errorPincode(exception: CustomException()));
    }
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      var userCredentials = await _firebaseRepository.signIn(credential);
      if (userCredentials.user != null) {
        var idToken = await userCredentials.user!.getIdToken();
        if (idToken != null) {
          _storeUserIdToken(idToken);
        } else {
          emit(AuthState.errorPincode(exception: CustomException()));
          return;
        }
        var userDetailsResp = await _userRepository.getCurrentUserDetails();
        userDetailsResp.fold(
          (left) {
            emit(AuthState.errorPincode(
                exception: CustomException('Unable to get user details')));
          },
          (user) async {
            var prefs = await SharedPreferences.getInstance();
            prefs.setString('user', jsonEncode(user.toJson()));
            if (user.emailVerified ?? false) {
              String? deviceToken;
              try {
                deviceToken = await FirebaseMessaging.instance.getToken();
              } catch (e) {
                _logger.d(e.toString());
              }
              String? deviceId;
              var deviceInfoPlugin = DeviceInfoPlugin();
              if (Platform.isAndroid) {
                var deviceInfo = await deviceInfoPlugin.androidInfo;
                deviceId = deviceInfo.id;
              } else if (Platform.isIOS) {
                var deviceInfo = await deviceInfoPlugin.iosInfo;
                deviceId = deviceInfo.identifierForVendor;
              }
              if (user.uid != null && deviceToken != null && deviceId != null) {
                await _firestoreRepository.updateUserDeviceToken(
                    user.uid!, deviceId, deviceToken);
              }
            }
            if (!(user.emailVerified ?? false)) {
              emit(const AuthState.inputEmail());
            } else if (user.customClaims?.birthday == null) {
              emit(const AuthState.createProfile());
            } else {
              emit(AuthState.authorized(user: userCredentials.user!));
            }
            // user.emailVerified ?? false ? emit(AuthState.authorized(user: userCredentials.user!)) : emit(const AuthState.inputEmail());
          },
        );
        // if (isSignUp) {
        //   emit(const AuthState.inputEmail());
        // } else {
        //   emit(AuthState.authorized(user: userCredentials.user!));
        // }
      } else {
        emit(AuthState.errorPincode(
            exception:
                CustomException('Unable to get user details from firebase')));
      }
    } on FirebaseAuthException catch (err) {
      emit(AuthState.errorPincode(exception: CustomException(err.message)));
    } catch (error) {
      emit(AuthState.errorPincode(exception: CustomException()));
    }
  }

  void _storeUserIdToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userIdToken', token);
  }

  // inputEmail() {
  //   emit(const AuthState.inputEmail());
  // }

  void verifyEmail(String email) async {
    emit(const AuthState.loading());
    try {
      await _firebaseRepository.updateEmail(email);
      var verifyEmailResp = await _userRepository.verifyEmail(email);
      if (verifyEmailResp.isRight) {
        emit(const AuthState.emailVerificationSent());
      } else {
        emit(AuthState.emailSendFailed(exception: verifyEmailResp.left));
      }
    } on AppException catch (e) {
      emit(AuthState.emailSendFailed(exception: e));
    } on FirebaseAuthException catch (e) {
      emit(AuthState.emailSendFailed(exception: CustomException(e.message)));
    } catch (e) {
      emit(AuthState.emailSendFailed(exception: CustomException()));
    }
  }

  void checkIfEmailVerified() {
    if (_firebaseRepository.isEmailVerified()) {
      emit(const AuthState.emailVerificationComplete());
    }
  }

  initial() {
    emit(const AuthState.initial());
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // return super.close();
    return Future.value();
  }
}
