import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/widgets/my_appbar.dart';
import 'package:flutter_chat_app/widgets/story_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppbar(
        title: 'Chats',
        actions: [
          Icon(
            Icons.message_outlined,
            color: AppColors.active,
            size: 28,
          ),
          SizedBox(width: 8),
          Icon(
            Icons.more_horiz,
            color: AppColors.active,
            size: 28,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          StoryWidget(),
        ],
      ),
    );
  }
}
