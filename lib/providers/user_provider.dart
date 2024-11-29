import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/user_model.dart';
import 'package:flutter_chat_app/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> updateUserProfile({
    required String firstName,
    String? lastName,
    File? profileImage,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _userService.updateUser(
        firstName: firstName,
        lastName: lastName,
        profileImage: profileImage,
      );

      
    } catch (e) {}
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
