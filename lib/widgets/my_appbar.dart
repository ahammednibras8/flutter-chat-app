import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Icon leadingIcon;
  const MyAppbar({super.key, required this.leadingIcon});

  @override
  final Size preferredSize = const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: leadingIcon,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
