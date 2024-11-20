import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/core/app_typography.dart';
import 'package:flutter_chat_app/model/messages_model.dart';
import 'package:flutter_chat_app/widgets/my_appbar.dart';

class ChatScreen extends StatelessWidget {
  final List<MessagesModel> _messages = [
    MessagesModel(
      text: "Hey, how are you?",
      isMe: true,
      time: "10:30 AM",
    ),
    MessagesModel(
      text: "I'm good, thanks! How about you?",
      isMe: false,
      time: "10:31 AM",
    ),
    MessagesModel(
      text: "I'm doing great! Just working on this new project.",
      isMe: true,
      time: "10:32 AM",
    ),
  ];
  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const MyAppbar(
          leadingIcon: Icon(Icons.arrow_back_ios_new_rounded),
          title: 'Ahammed Nibras',
          actions: [
            Icon(
              Icons.more_vert_outlined,
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.white,
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return MessageBubble(
                      message: message,
                    );
                  },
                ),
              ),
            ),
            const ChatTypingWidget(),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final MessagesModel message;
  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 16,
          left: message.isMe ? 64 : 0,
          right: message.isMe ? 0 : 64,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isMe ? AppColors.defaultColor : AppColors.offWhite,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isMe ? 16 : 0),
            bottomRight: Radius.circular(message.isMe ? 0 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.text,
              style: AppTypography.body2.copyWith(
                color: message.isMe ? AppColors.white : AppColors.active,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.time,
                  style: AppTypography.body2.copyWith(
                    color: message.isMe ? AppColors.white : AppColors.active,
                  ),
                ),
                if (message.isMe) ...[
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.done_all_outlined,
                    size: 16,
                    color: AppColors.white,
                  )
                ]
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ChatTypingWidget extends StatelessWidget {
  const ChatTypingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 12, right: 16),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: AppColors.disabled,
              ),
            ),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Type a message",
                  hintStyle: TextStyle(color: AppColors.disabled),
                  filled: true,
                  fillColor: AppColors.offWhite,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Transform.rotate(
                angle: -3.14 / 4,
                child: const Icon(
                  Icons.send,
                  color: AppColors.defaultColor,
                  size: 24,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
