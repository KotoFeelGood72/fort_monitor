import 'package:flutter/material.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';
import 'package:fort_monitor/presentation/widget/icons.dart' as custom_icons;
import 'package:fort_monitor/presentation/widget/inputs/custom_calendar.dart';

class CustomDateInput extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? initialValue;
  final bool isRequired;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool enabled;
  final VoidCallback? onTap;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime? start, DateTime? end)? onDateRangeSelected;

  const CustomDateInput({
    super.key,
    required this.label,
    this.hintText,
    this.initialValue,
    this.isRequired = false,
    this.onChanged,
    this.validator,
    this.controller,
    this.enabled = true,
    this.onTap,
    this.startDate,
    this.endDate,
    this.onDateRangeSelected,
  });

  String? _getDefaultValidator(String? value) {
    if (isRequired && (value == null || value.trim().isEmpty)) {
      return 'Это поле обязательно для заполнения';
    }
    if (value != null && value.isNotEmpty) {
      if (!RegExp(r'^\d{2}\.\d{2}\.\d{4}$').hasMatch(value)) {
        return 'Введите корректную дату (ДД.ММ.ГГГГ)';
      }
    }
    return null;
  }

  void _showCalendarModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: CustomCalendar(
          startDate: startDate,
          endDate: endDate,
          onDateRangeSelected: (start, end) {
            onDateRangeSelected?.call(start, end);
            if (controller != null && start != null && end != null) {
              final startStr =
                  '${start.day.toString().padLeft(2, '0')}.${start.month.toString().padLeft(2, '0')}.${start.year}';
              final endStr =
                  '${end.day.toString().padLeft(2, '0')}.${end.month.toString().padLeft(2, '0')}.${end.year}';
              controller!.text = '$startStr - $endStr';
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultValidator = _getDefaultValidator;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(
            label + (isRequired ? ' *' : ''),
            style: AppFonts.jostMedium.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        if (label.isNotEmpty) const SizedBox(height: 10),
        GestureDetector(
          onTap: enabled
              ? () {
                  if (onTap != null) {
                    onTap!();
                  } else {
                    _showCalendarModal(context);
                  }
                }
              : null,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.greyCard,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextFormField(
              controller: controller,
              initialValue: controller == null ? initialValue : null,
              keyboardType: TextInputType.datetime,
              onChanged: onChanged,
              validator: validator ?? defaultValidator,
              enabled: false, // Делаем поле неактивным для прямого ввода
              decoration: InputDecoration(
                hintText: hintText ?? 'Выберите дату',
                filled: false,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: custom_icons.Icons(
                    iconName: 'datePicker',
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              style: AppFonts.jostMedium.copyWith(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
