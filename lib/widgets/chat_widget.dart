import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/core/app_typography.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(),
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
                child: Image.asset(
                  'assets/images/profile.jpeg',
                  fit: BoxFit.cover,
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
                        'Ahammed Nibras',
                        style: AppTypography.body1.copyWith(
                          color: AppColors.active,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Good morning, did you sleep well?',
                        style: AppTypography.metadata1.copyWith(
                          color: AppColors.disabled,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Today',
                        style: AppTypography.metadata2.copyWith(
                          color: AppColors.disabled,
                        ),
                      ),
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
