import 'package:flutter/material.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';

class CustomRadioGroup<T> extends StatelessWidget {
  final String? label;
  final List<RadioOption<T>> options;
  final T? selectedValue;
  final Function(T?) onChanged;
  final bool enabled;
  final bool isRequired;

  const CustomRadioGroup({
    super.key,
    this.label,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.enabled = true,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...options.map((option) => _buildRadioOption(option)).toList(),
      ],
    );
  }

  Widget _buildRadioOption(RadioOption<T> option) {
    final isSelected = selectedValue == option.value;

    return GestureDetector(
      onTap: enabled ? () => onChanged(option.value) : null,
      child: Container(
        child: Row(
          spacing: 7,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: enabled
                      ? (isSelected ? Colors.black : Colors.grey[400]!)
                      : Colors.grey[300]!,
                  width: 1,
                ),
                color: enabled && isSelected
                    ? Colors.black
                    : Colors.transparent,
              ),
            ),

            Expanded(
              child: Text(
                option.label,
                style: AppFonts.jostMedium.copyWith(
                  fontSize: 14,
                  color: enabled
                      ? (isSelected ? Colors.black : AppColors.grey)
                      : AppColors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadioOption<T> {
  final String label;
  final T value;

  const RadioOption({required this.label, required this.value});
}
