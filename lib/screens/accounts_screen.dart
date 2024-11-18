import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/widgets/my_appbar.dart';
import 'package:flutter_chat_app/widgets/my_text_field.dart';
import 'package:flutter_chat_app/widgets/profile_pic_selector.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppbar(
        title: 'My Account',
        actions: [
          Icon(
            Icons.settings_outlined,
            color: AppColors.active,
            size: 28,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfilePicSelector(),
              SizedBox(height: 32),
              MyTextField(label: 'First Name'),
              SizedBox(height: 16),
              MyTextField(label: 'Last Name'),
            ],
          ),
        ),
      ),
    );
  }
}
