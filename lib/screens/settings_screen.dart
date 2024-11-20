import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/core/app_typography.dart';
import 'package:flutter_chat_app/screens/accounts_screen.dart';
import 'package:flutter_chat_app/widgets/my_appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: AppColors.active,
        size: 24,
      ),
      title: Text(
        title,
        style: AppTypography.body1,
      ),
      trailing: trailing ??
          const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 16,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(
        leadingIcon: Icon(Icons.arrow_back_ios_new_rounded),
        title: 'Settings',
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopProfileSection(),
                    const Divider(),
                    _settingsTile(
                      icon: Icons.person_2_outlined,
                      title: 'Account',
                      onTap: () {},
                    ),
                    _settingsTile(
                      icon: Icons.security_outlined,
                      title: "Privacy",
                      onTap: () {},
                    ),
                    _settingsTile(
                      icon: Icons.chat_bubble_outline,
                      title: "Chat Settings",
                      onTap: () {},
                    ),
                    _settingsTile(
                      icon: Icons.notifications_outlined,
                      title: "Notifications",
                      onTap: () {},
                    ),
                    const Divider(),
                    _settingsTile(
                      icon: Icons.help_outline,
                      title: "help",
                      onTap: () {},
                    ),
                    _settingsTile(
                      icon: Icons.message_outlined,
                      title: "Invite",
                      onTap: () {},
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Made with ❤️ by',
                  style: AppTypography.metadata1.copyWith(
                    color: AppColors.disabled,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ahammed Nibras',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.defaultColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopProfileSection extends StatelessWidget {
  const TopProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AccountsScreen(),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.disabled,
              child: Icon(
                Icons.person,
                size: 36,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Text(
                    "Ahammed Nibras",
                    style: AppTypography.body1.copyWith(
                      color: AppColors.active,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '+91 9544995167',
                    style: AppTypography.metadata1.copyWith(
                      color: AppColors.disabled,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.active,
            ),
          ],
        ),
      ),
    );
  }
}
