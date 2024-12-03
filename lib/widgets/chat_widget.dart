import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/core/app_typography.dart';
import 'package:flutter_chat_app/model/chat_model.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';

class ChatWidget extends StatelessWidget {
  final ChatModel chat;
  final String currentUserId;

  const ChatWidget({
    super.key,
    required this.chat,
    required this.currentUserId,
  });

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    if (time.year == now.year &&
        time.month == now.month &&
        time.day == now.day) {
      return '${time.day.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
    return '${time.day}/${time.month}';
  }

  @override
  Widget build(BuildContext context) {
    final isLastMessageMine = chat.lastMessageSenderId == currentUserId;
    final otherParticipats =
        chat.participants.firstWhere((id) => id != currentUserId);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(chatId: chat.id),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: chat.isGroup && chat.groupImage != null
                    ? Image.network(
                        chat.groupImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTree) => const Icon(
                          Icons.group,
                          size: 32,
                          color: AppColors.active,
                        ),
                      )
                    : const Icon(
                        Icons.person,
                        size: 32,
                        color: AppColors.active,
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.isGroup
                            ? chat.groupName ?? 'GroupChat'
                            : otherParticipats,
                        style: AppTypography.body1.copyWith(
                          color: AppColors.active,
                          fontWeight: chat.unreadCount > 0 && !isLastMessageMine
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (isLastMessageMine)
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.done_all,
                                size: 16,
                                color: AppColors.disabled,
                              ),
                            ),
                          Text(
                            chat.lastMessage,
                            style: AppTypography.metadata1.copyWith(
                              color: chat.unreadCount > 0 && !isLastMessageMine
                                  ? AppColors.active
                                  : AppColors.disabled,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatTime(chat.lastMessageTime),
                        style: AppTypography.metadata2.copyWith(
                          color: chat.unreadCount > 0 && !isLastMessageMine
                              ? AppColors.active
                              : AppColors.disabled,
                        ),
                      ),
                      if (chat.unreadCount > 0 && !isLastMessageMine) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.defaultColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            chat.unreadCount.toString(),
                            style: AppTypography.metadata2.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ]
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
