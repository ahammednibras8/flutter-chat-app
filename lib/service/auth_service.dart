import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sentOtp(String phoneNumber, Function onCodeSent) async {
    if (phoneNumber.isEmpty || !phoneNumber.startsWith('+')) {
      print("Invalid phone number");
      throw Exception(
          "Phone number must be in international format and not empty");
    }

    print("Sending OTP to: $phoneNumber");

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        throw Exception(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(
          "Verification timeout occurred. Verification ID: $verificationId",
        );
      },
    );
  }

  Future<void> verifyOtp(String verificationId, String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    await _auth.signInWithCredential(credential);
  }
}
