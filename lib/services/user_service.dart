import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_chat_app/model/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) {
        // Create initial user document if it doesn't exist
        final initialUser = UserModel(
          uid: user.uid,
          firstName: user.displayName?.split(' ').first ?? '',
          lastName: user.displayName?.split(' ').skip(1).join(' '),
          phoneNumber: user.phoneNumber,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(initialUser.toMap());
        return initialUser;
      }

      return UserModel.fromMap({...doc.data()!, 'uid': user.uid});
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  Future<String?> uploadProfileImage(File image) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final ref = _storage
          .ref()
          .child('profile_images')
          .child('${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg');

      await ref.putFile(image);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading profile image: $e');
      return null;
    }
  }

  Future<bool> updateProfile({
    required String firstName,
    String? lastName,
    File? profileImage,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      final updates = {
        'firstName': firstName,
        'lastName': lastName,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (profileImage != null) {
        final imageUrl = await uploadProfileImage(profileImage);
        if (imageUrl != null) {
          updates['profileImage'] = imageUrl;
        }
      }

      await _firestore.collection('users').doc(user.uid).update(updates);
      return true;
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }
}
