import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/core/app_typography.dart';

class LoginInfoText extends StatelessWidget {
  final String title;
  final String subtitle;
  const LoginInfoText({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppTypography.heading2.copyWith(
            color: AppColors.active,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: AppTypography.body2.copyWith(
            color: AppColors.active,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
