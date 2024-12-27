import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/auth_model.dart';
import 'package:flutter_chat_app/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final AuthModel _authModel = AuthModel();

  bool get isLoading => _authModel.isLoading;

  Future<void> sendOtp(String phoneNumber, Function onCodeSent) async {
    _authModel.setLoading(true);
    try {
      await _authService.sentOtp(phoneNumber, onCodeSent);
    } catch (e) {
      rethrow;
    } finally {
      _authModel.setLoading(false);
    }
  }

  Future<void> verifyOtp(
    String verificationId,
    String otp,
    Function onSuccess,
  ) async {
    _authModel.setLoading(true);

    try {
      await _authService.verifyOtp(verificationId, otp);
      onSuccess();
    } catch (e) {
      rethrow;
    } finally {
      _authModel.setLoading(false);
    }
  }
}
