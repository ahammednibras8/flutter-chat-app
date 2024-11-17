import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/core/app_typography.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Icon leadingIcon;
  final String? title;
  const MyAppbar({super.key, required this.leadingIcon, this.title});

  @override
  final Size preferredSize = const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: IconButton(
          icon: leadingIcon,
          onPressed: () => Navigator.pop(context),
        ),
        title: title != null
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title!,
                  style: AppTypography.subheading1.copyWith(
                    color: AppColors.active,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
