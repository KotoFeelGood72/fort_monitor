import 'package:flutter/material.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';

class DefaultCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const DefaultCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 40),
        decoration: BoxDecoration(
          color: AppColors.greyCard,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(title, style: AppFonts.jostRegular.copyWith(fontSize: 20)),
      ),
    );
  }
}
