import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/user_model.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<void> createUser(UserModel user) async {
    try {
      if (currentUser != null) {
        await _firestore
            .collection('user')
            .doc(currentUser!.uid)
            .set(user.toMap());
      }
    } catch (e) {
      debugPrint('Error Creating/Updating User: $e');
      rethrow;
    }
  }

  Future<UserModel?> getUserData() async {
    try {
      if (currentUser != null) {
        final doc =
            await _firestore.collection('user').doc(currentUser!.uid).get();
        if (doc.exists) {
          return UserModel.fromMap(doc.data()!, doc.id);
        }
      }
    } catch (e) {
      debugPrint('Error fetching Data: $e');
      rethrow;
    }

    return null;
  }
}
