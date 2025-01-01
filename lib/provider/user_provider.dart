import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/user_model.dart';
import 'package:flutter_chat_app/service/user_service.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final UserService _userService = UserService();

  UserModel? get user => _user;

  Future<void> loadUserData() async {
    try {
      _user = await _userService.getUserData();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
  }

  Future<void> saveUserData(UserModel user) async {
    try {
      await _userService.createUser(user);
      _user = user;
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving user data: $e');
    }
  }
}
