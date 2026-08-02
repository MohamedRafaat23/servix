import 'package:flutter/material.dart';
import 'package:servix/core/utils/functions/responsive.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ProfileAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: context.responsiveFontScale(18),
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1E293B),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}