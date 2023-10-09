import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

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

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
