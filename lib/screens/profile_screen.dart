import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/provider/user_provider.dart';
import 'package:flutter_chat_app/screens/chat_home_screen.dart';
import 'package:flutter_chat_app/widgets/my_appbar.dart';
import 'package:flutter_chat_app/widgets/my_button.dart';
import 'package:flutter_chat_app/widgets/my_text_field.dart';
import 'package:flutter_chat_app/widgets/profile_pic_selector.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = context.read<UserProvider>().user;
      if (user != null) {
        _firstNameController.text = user.firstName;
        _lastNameController.text = user.lastName;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    final navigator = Navigator.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const MyAppbar(
          leadingIcon: Icon(Icons.arrow_back_ios_new_outlined),
          title: 'Your Profile',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 48),
                ProfilePicSelector(
                  onImageSelected: (file) {
                    _profileImage = file;
                  },
                ),
                const SizedBox(height: 31),
                MyTextField(
                  label: "First Name (Required)",
                  controller: _firstNameController,
                ),
                const SizedBox(height: 16),
                MyTextField(
                  label: "Last Name (Optional)",
                  controller: _lastNameController,
                ),
                const SizedBox(height: 48),
                MyButton(
                  text: 'Save',
                  onPressed: () async {
                    final user = userProvider.user;

                    final updatedUser = user.copyWith(
                      firstName: _firstNameController.text.trim(),
                      lastName: _lastNameController.text.trim(),
                      profilePicUrl: _profileImage?.path ?? user.profilePicUrl,
                    );

                    await userProvider.saveUserData(updatedUser);

                    if (mounted) {
                      navigator.pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const ChatHomeScreen(),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 24)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
