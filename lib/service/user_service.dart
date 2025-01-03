import 'dart:io';

import 'package:flutter_chat_app/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<UserModel?> getUserData(String uid) async {
    final response =
        await _client.from('user').select().eq('uid', uid).single();
    return UserModel.fromMap(response);
  }

  Future<void> saveUserData(UserModel user) async {
    await _client.from('users').upsert(user.toMap());
  }

  Future<String> uploadProfilePicture(File file) async {
    final fileName = file.path.split('/').last;

    final publicUrl =
        _client.storage.from('profile-pics').getPublicUrl(fileName);
    return publicUrl;
  }
}
