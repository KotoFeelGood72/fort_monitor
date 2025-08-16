import 'package:flutter/material.dart';
import 'icons.dart' as custom_icons;
import 'package:fort_monitor/presentation/theme/app_fonts.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';

class DefaultButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const DefaultButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greyCard,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: AppFonts.jostRegular.copyWith(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
