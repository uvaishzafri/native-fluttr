import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:native/util/exceptions.dart';

@lazySingleton
class FirebaseRepository {
  FirebaseRepository(this._auth);
  final FirebaseAuth _auth;

  Future<void> submitPhoneNumber(
      String phoneNumber,
      PhoneVerificationCompleted verificationCompleted,
      PhoneVerificationFailed verificationFailed,
      PhoneCodeSent codeSent) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  PhoneAuthCredential submitOTP(String otpCode, String verificationId) {
    return PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
  }

  Future<UserCredential> signIn(PhoneAuthCredential credential) async {
    return await _auth.signInWithCredential(credential);
  }

  Future<void> verifyEmail(String email) async {
    if (_auth.currentUser == null) {
      throw CustomException('Could not get current user');
    }
    await _auth.currentUser?.updateEmail(email);
    return await _auth.currentUser?.sendEmailVerification(
      ActionCodeSettings(
        url: 'https://dev.be-native.me/linking',
        handleCodeInApp: false,
        androidInstallApp: true,
        androidPackageName: 'me.benative.mobile',
        iOSBundleId: 'me.benative.mobile',
        // dynamicLinkDomain: 'https://dev.be-native.me/linking',
      ),
    );
    // return await _auth.currentUser!.verifyBeforeUpdateEmail(
    //   email,
    //   // ActionCodeSettings(
    //   //   url: 'https://www.example.com',
    //   //   androidPackageName: 'me.benative.mobile',
    //   //   iOSBundleId: 'me.benative.mobile',
    //   // ),
    // );
  }

  bool isEmailVerified() {
    _auth.currentUser?.reload();
    return _auth.currentUser?.emailVerified ?? false;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
