import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/core/app_typography.dart';

class MyBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem('Contacts', Icons.contacts_outlined, 0),
          _buildNavItem('Chat', Icons.chat_outlined, 1),
          _buildNavItem('Account', Icons.person_outlined, 2),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon, int index) {
    final isSelected = currentIndex == index;
    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isSelected) ...[
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Lato',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 0.7,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: AppColors.active,
                shape: BoxShape.circle,
              ),
            )
          ] else
            Icon(
              icon,
              color: AppColors.active,
            )
        ],
      ),
    );
  }
}
