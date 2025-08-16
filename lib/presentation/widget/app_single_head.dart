import 'package:flutter/material.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';
import 'icons.dart' as custom_icons;

class AppSingleHead extends StatelessWidget implements PreferredSizeWidget {
  const AppSingleHead({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: custom_icons.Icons(
          iconName: 'arrowBack',
          size: 24,
          color: Colors.black87,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(title, style: AppFonts.heading3),
      backgroundColor: AppColors.bg,
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
