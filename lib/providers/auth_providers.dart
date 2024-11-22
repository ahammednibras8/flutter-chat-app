import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/auth_service.dart';

class AuthProviders extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool isLoading = false;
  String? error;
  User? get currentUser => _authService.currentUser;

  void verifyPhone({
    required String phoneNumber,
    required Function(String) onCodeSent,
  }) {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      _authService.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await _authService.verifyOTP(
              verificationId: credential.verificationId ?? '',
              smsCode: credential.smsCode ?? '',
            );
            isLoading = false;
            notifyListeners();
          } catch (e) {
            isLoading = false;
            error = e.toString();
            notifyListeners();
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          isLoading = false;
          error = e.message;
          notifyListeners();
        },
        codeSent: (String verificationId, int? resendToken) {
          isLoading = false;
          onCodeSent(verificationId);
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout if needed
          isLoading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> verifyOTP({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await _authService.verifyOTP(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    notifyListeners();
  }
}
