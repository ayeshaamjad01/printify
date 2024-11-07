// lib/custom_app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool centerTitle;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = const Color.fromARGB(255, 254, 110, 0),
    this.foregroundColor = Colors.white,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: foregroundColor),
      ),
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      foregroundColor: foregroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
