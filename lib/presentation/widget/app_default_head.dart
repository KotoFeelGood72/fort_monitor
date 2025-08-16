import 'package:flutter/material.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';

class AppDefaultHead extends StatelessWidget implements PreferredSizeWidget {
  const AppDefaultHead({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.bg,
      elevation: 0,
      shadowColor: Colors.transparent,
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
