import 'package:flutter/material.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';

class ReportCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const ReportCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          color: AppColors.greyCard,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text(title, style: AppFonts.jostRegular.copyWith(fontSize: 18)),
            Container(
              width: 38,
              height: 38,
              child: Image.asset('assets/images/uploadFile.png'),
            ),
          ],
        ),
      ),
    );
  }
}
