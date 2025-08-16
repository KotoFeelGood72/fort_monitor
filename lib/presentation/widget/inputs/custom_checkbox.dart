import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';

class CustomCheckbox extends StatelessWidget {
  final String label;
  final ValueNotifier<bool> controller;
  final Function(bool)? onChanged;
  final bool enabled;

  const CustomCheckbox({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller,
      builder: (context, isChecked, child) {
        return GestureDetector(
          onTap: enabled
              ? () {
                  final newValue = !isChecked;
                  controller.value = newValue;
                  onChanged?.call(newValue);
                }
              : null,
          child: Row(
            spacing: 7,
            children: [
              SvgPicture.asset(
                isChecked
                    ? 'assets/icons/checkFill.svg'
                    : 'assets/icons/checkSquare.svg',
                width: 18,
                height: 18,
                colorFilter: enabled
                    ? null
                    : const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
              ),
              Expanded(
                child: Text(
                  label,
                  style: AppFonts.jostMedium.copyWith(
                    fontSize: 14,
                    color: enabled
                        ? (isChecked ? Colors.black : AppColors.grey)
                        : AppColors.grey,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
