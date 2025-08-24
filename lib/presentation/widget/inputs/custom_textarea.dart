import 'package:flutter/material.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';

class CustomTextarea extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? initialValue;
  final bool isRequired;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final double? height;

  const CustomTextarea({
    super.key,
    required this.label,
    this.hintText,
    this.initialValue,
    this.isRequired = false,
    this.onChanged,
    this.validator,
    this.controller,
    this.enabled = true,
    this.maxLines,
    this.maxLength,
    this.height,
  });

  String? _getDefaultValidator(String? value) {
    if (isRequired && (value == null || value.trim().isEmpty)) {
      return 'Это поле обязательно для заполнения';
    }
    return null;
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
        Container(
          height: height ?? 120,
          decoration: BoxDecoration(
            color: AppColors.greyCard,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextFormField(
            controller: controller,
            initialValue: controller == null ? initialValue : null,
            keyboardType: TextInputType.multiline,
            onChanged: onChanged,
            validator: validator ?? defaultValidator,
            enabled: enabled,
            maxLines: maxLines ?? null,
            maxLength: maxLength,
            expands: height != null,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText: hintText,
              filled: false,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              counterText: '', // Скрываем счетчик символов
            ),
            style: AppFonts.jostMedium.copyWith(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}



