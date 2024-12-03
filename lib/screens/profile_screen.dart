import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/providers/user_provider.dart';
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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  File? _selectedImage;
  bool _isLoading = false;
  // ignore: unused_field
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _loadUser());
  }

  Future<void> _loadUser() async {
    final provider = context.read<UserProvider>();
    await provider.loadUser();

    if (!mounted) return;

    final user = provider.user;
    if (user != null) {
      setState(() {
        _firstNameController.text = user.firstName;
        _lastNameController.text = user.lastName ?? '';
      });
    }
  }

  Future<void> _updateProfile() async {
    if (_firstNameController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'First name is required';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final success = await context.read<UserProvider>().updateProfile(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim().isEmpty
              ? null
              : _lastNameController.text.trim(),
          profileImage: _selectedImage,
        );

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
          ),
        );

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ChatHomeScreen(),
          ),
          (route) => false,
        );
      } else {
        setState(() {
          _errorMessage =
              context.read<UserProvider>().error ?? 'Failed to update profile';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  currentImageUrl:
                      context.watch<UserProvider>().user?.profileImage,
                  onImageSelected: (file) {
                    setState(() {
                      _selectedImage = file;
                    });
                  },
                ),
                const SizedBox(height: 31),
                MyTextField(
                  label: "First Name (Required)",
                  controller: _firstNameController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'First name is required';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 16),
                MyTextField(
                  label: "Last Name (Optional)",
                  controller: _lastNameController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 48),
                MyButton(
                  text: 'Continue',
                  onPressed: _isLoading ? null : _updateProfile,
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
