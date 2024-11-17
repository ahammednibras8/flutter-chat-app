import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_colors.dart';
import 'package:flutter_chat_app/core/app_typography.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Icon? leadingIcon;
  final String? title;
  final VoidCallback? onLeadingPressed;
  final List<Widget>? actions;

  const MyAppbar({
    super.key,
    this.leadingIcon,
    this.title,
    this.onLeadingPressed,
    this.actions,
  });

  @override
  final Size preferredSize = const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: leadingIcon != null ? 0 : 16,
        leading: leadingIcon != null
            ? IconButton(
                icon: leadingIcon!,
                onPressed: onLeadingPressed ?? () => Navigator.pop(context),
              )
            : null,
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
        actions: actions != null
            ? [
                ...actions!,
                const SizedBox(width: 8),
              ]
            : null,
      ),
    );
  }
}
