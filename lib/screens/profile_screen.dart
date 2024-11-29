import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/core/app_typography.dart';
import 'package:flutter_chat_app/providers/user_provider.dart';
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

  Future<void> _saveProfile() async {
    final firstName = _firstNameController.text.trim();
    if (firstName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('First name is required'),
          backgroundColor: AppColors.danger,
        ),
      );
      return;
    }

    try {
      await context.read<UserProvider>().updateUserProfile(
            firstName: firstName,
            lastName: _lastNameController.text.trim(),
            profileImage: _selectedImage,
          );

      if (!mounted) return;

      if (context.read<UserProvider>().error == null) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppColors.danger,
        ),
      );
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
        body: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            if (userProvider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.defaultColor,
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                    ProfilePicSelector(
                      currentImageUrl: userProvider.user?.profileImage,
                      onImageSelected: (File file) {
                        setState(() => _selectedImage = file);
                        userProvider.clearError();
                      },
                    ),
                    const SizedBox(height: 31),
                    if (userProvider.error != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          userProvider.error!,
                          style: AppTypography.body2.copyWith(
                            color: AppColors.danger,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    MyTextField(
                      label: "First Name (Required)",
                      controller: _firstNameController,
                      onChanged: (_) => userProvider.clearError(),
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
                      onChanged: (_) => userProvider.clearError(),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 48),
                    MyButton(
                      text: userProvider.isLoading ? 'Loading...' : 'Save',
                      onPressed: userProvider.isLoading ? null : () => _saveProfile(),
                    ),
                    const SizedBox(height: 24)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
