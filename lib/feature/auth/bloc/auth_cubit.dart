import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:native/repo/firebase_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._firebaseRepository, this._logger) : super(const AuthState.initial());

  final FirebaseRepository _firebaseRepository;
  final Logger _logger;
  late String verificationId;
  late bool isSignUp;

  void submitPhoneNumber(String phoneNumber, bool isSignUp) {
    this.isSignUp = isSignUp;
    _firebaseRepository.submitPhoneNumber(phoneNumber, verificationCompleted, verificationFailed, codeSent);
    emit(const AuthState.inputPincode());
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    _logger.d("verificationCompleted");
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    _logger.d('verificationFailed : ${error.toString()}');
    emit(AuthState.failed(exception: error));
  }

  void codeSent(String verificationId, int? resendToken) {
    _logger.d("verificationId : $verificationId");
    this.verificationId = verificationId;
    emit(const AuthState.inputPincode());
  }

  Future<void> inputPincode(String otpCode) async {
    try {
      PhoneAuthCredential credential = _firebaseRepository.submitOTP(otpCode, verificationId);
      await signIn(credential);
    } catch (error) {
      emit(const AuthState.errorPincode());
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
          emit(AuthState.failed(exception: Exception('Unable to get user token from firebase')));
          return;
        }
        if (isSignUp) {
          emit(const AuthState.inputEmail());
        } else {
          emit(AuthState.authorized(user: userCredentials.user!));
        }
      } else {
        emit(AuthState.failed(exception: Exception('Unable to get user details from firebase')));
      }
    } catch (error) {
      emit(const AuthState.errorPincode());
    }
  }

  void _storeUserIdToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userIdToken', token);
  }

  inputEmail() {
    emit(const AuthState.inputEmail());
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
