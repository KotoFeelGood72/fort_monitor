import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';

// Экспорт CustomTextarea
export 'custom_textarea.dart';
// Экспорт CustomDateInput
export 'custom_date_input.dart';
// Экспорт CustomCalendar
export 'custom_calendar.dart';

enum InputType { text, number, phone, date }

class CustomInput extends StatelessWidget {
  final String? label;
  final InputType type;
  final String? hintText;
  final String? initialValue;
  final bool isRequired;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final TextAlign textAlign;
  final double? fontSize;
  final double borderRadius;
  final double? height;

  const CustomInput({
    super.key,
    this.label,
    required this.type,
    this.hintText,
    this.initialValue,
    this.isRequired = false,
    this.onChanged,
    this.validator,
    this.controller,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.textAlign = TextAlign.left,
    this.fontSize,
    this.borderRadius = 20.0,
    this.height,
  });

  TextInputFormatter? _getInputFormatter() {
    switch (type) {
      case InputType.phone:
        return MaskTextInputFormatter(
          mask: '+7 (###) ###-##-##',
          filter: {"#": RegExp(r'[0-9]')},
        );
      case InputType.date:
        return MaskTextInputFormatter(
          mask: '##.##.####',
          filter: {"#": RegExp(r'[0-9]')},
        );
      case InputType.number:
        return FilteringTextInputFormatter.digitsOnly;
      case InputType.text:
      default:
        return null;
    }
  }

  TextInputType _getKeyboardType() {
    switch (type) {
      case InputType.phone:
        return TextInputType.phone;
      case InputType.number:
        return TextInputType.number;
      case InputType.date:
        return TextInputType.datetime;
      case InputType.text:
      default:
        return TextInputType.text;
    }
  }

  String? _getDefaultValidator(String? value) {
    if (isRequired && (value == null || value.trim().isEmpty)) {
      return 'Это поле обязательно для заполнения';
    }

    if (value != null && value.isNotEmpty) {
      switch (type) {
        case InputType.phone:
          if (!value.contains('(') || !value.contains(')')) {
            return 'Введите корректный номер телефона';
          }
          break;
        case InputType.date:
          if (!RegExp(r'^\d{2}\.\d{2}\.\d{4}$').hasMatch(value)) {
            return 'Введите корректную дату (ДД.ММ.ГГГГ)';
          }
          break;
        case InputType.number:
          if (int.tryParse(value) == null) {
            return 'Введите корректное число';
          }
          break;
        default:
          break;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final inputFormatter = _getInputFormatter();
    final keyboardType = _getKeyboardType();
    final defaultValidator = _getDefaultValidator;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && label!.isNotEmpty)
          Text(
            label! + (isRequired ? ' *' : ''),
            style: AppFonts.jostMedium.copyWith(color: Colors.black),
          ),
        if (label != null && label!.isNotEmpty) const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          keyboardType: keyboardType,
          inputFormatters: inputFormatter != null ? [inputFormatter] : null,
          onChanged: onChanged,
          validator: validator ?? defaultValidator,
          enabled: enabled,
          maxLines: maxLines,
          maxLength: maxLength,
          textAlign: textAlign,
          style: fontSize != null
              ? AppFonts.jostRegular.copyWith(fontSize: fontSize)
              : null,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: enabled ? AppColors.greyCard : AppColors.bg,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: Colors.black, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 0,
            ),
            constraints: height != null
                ? BoxConstraints(minHeight: height!, maxHeight: height!)
                : null,
          ),
        ),
      ],
    );
  }
}
