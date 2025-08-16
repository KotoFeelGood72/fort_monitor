import 'package:flutter/material.dart';
import 'icons.dart' as custom_icons;
import 'package:fort_monitor/presentation/theme/app_fonts.dart';

class SaveButton extends StatelessWidget {
  final Function() onPressed;
  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 71,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[600],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Сохранить',
              style: AppFonts.jostRegular.copyWith(fontSize: 20),
            ),
            const SizedBox(width: 9),
            Container(
              margin: EdgeInsets.only(top: 3),
              child: custom_icons.Icons(
                iconName: 'longArrow',
                size: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
