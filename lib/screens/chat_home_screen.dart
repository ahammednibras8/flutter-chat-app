import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/screens/accounts_screen.dart';
import 'package:flutter_chat_app/screens/contacts_screen.dart';
import 'package:flutter_chat_app/widgets/chat_widget.dart';
import 'package:flutter_chat_app/widgets/my_appbar.dart';
import 'package:flutter_chat_app/widgets/my_bottom_navigation.dart';
import 'package:flutter_chat_app/widgets/my_text_field.dart';
import 'package:flutter_chat_app/widgets/story_widget.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  int _currentIndex = 1;

  final List<Widget> _screens = const [
    ContactsScreen(),
    ChatMainScreen(),
    AccountsScreen(),
  ];

  void onNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: MyBottomNavigation(
          currentIndex: _currentIndex,
          onTap: onNavigationTap,
        ),
      ),
    );
  }
}

class ChatMainScreen extends StatelessWidget {
  const ChatMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(
        title: 'Chats',
        actions: [
          Icon(
            Icons.person_add_alt_1_outlined,
            color: AppColors.active,
            size: 28,
          ),
          SizedBox(width: 12),
          Icon(
            Icons.settings_outlined,
            color: AppColors.active,
            size: 28,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          const StoryWidget(),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.disabled,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                MyTextField(label: 'Search...'),
                SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => const ChatWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
