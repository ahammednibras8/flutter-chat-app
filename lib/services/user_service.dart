import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_chat_app/model/user_model.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  User? get currentUser => _auth.currentUser;

  Future<String> uploadProfileImage(File image) async {
    final user = currentUser;
    if (user == null) throw Exception('No authenticated user found.');

    final ref = _storage.ref().child('profile_images/@{user.uid}');
    final uploadTask = await ref.putFile(image);
    return await uploadTask.ref.getDownloadURL();
  }

  Future<void> updateUser({
    required String firstName,
    String? lastName,
    File? profileImage,
  }) async {
    final user = currentUser;
    if (user == null) throw Exception('No authenticated user found.');

    String? imageUrl;
    if (profileImage != null) {
      imageUrl = await uploadProfileImage(profileImage);
    }

    final userDoc = await _firestore.collection('users').doc(user.uid).get();
    final now = DateTime.now();

    if (!userDoc.exists) {
      final newUser = UserModel(
        uid: user.uid,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: user.phoneNumber ?? '',
        profileImage: imageUrl,
        createdAt: now,
        updatedAt: now,
      );

      await _firestore.collection('users').doc(user.uid).set(newUser.toMap());
    } else {
      final data = userDoc.data()!;
      final updatedUser = UserModel(
        uid: user.uid,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: data['phoneNumber'] as String,
        profileImage: imageUrl ?? data['profileImage'] as String?,
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        updatedAt: now,
      );

      await _firestore
          .collection('users')
          .doc(user.uid)
          .update(updatedUser.toMap());
    }
  }
}
