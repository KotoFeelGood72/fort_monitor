import 'package:flutter/material.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';

class CustomRadioGroup<T> extends StatelessWidget {
  final String? label;
  final List<RadioOption<T>> options;
  final T? selectedValue;
  final Function(T?) onChanged;
  final bool isRequired;
  final bool showInput;
  final String? inputHint;
  final String? inputValue;
  final TextEditingController? inputController;
  final Function(String)? onInputChanged;

  const CustomRadioGroup({
    super.key,
    this.label,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.isRequired = false,
    this.showInput = false,
    this.inputHint,
    this.inputValue,
    this.inputController,
    this.onInputChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && label!.isNotEmpty)
          Text(
            label! + (isRequired ? ' *' : ''),
            style: AppFonts.jostMedium.copyWith(color: Colors.black),
          ),
        if (label != null && label!.isNotEmpty) const SizedBox(height: 12),

        // Radio options
        Column(
          children: options.map((option) => _buildRadioOption(option)).toList(),
        ),

        // Empty input field (shown when showInput is true)
        if (showInput) ...[
          const SizedBox(height: 10),
          Container(
            height: 44,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.greyCard,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: inputController ?? TextEditingController(text: inputValue ?? ''),
              onChanged: onInputChanged,
              decoration: InputDecoration(
                hintText: inputHint ?? '',
                border: InputBorder.none,
                hintStyle: AppFonts.jostRegular.copyWith(
                  fontSize: 15,
                  color: AppColors.grey,
                ),
              ),
              style: AppFonts.jostRegular.copyWith(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRadioOption(RadioOption<T> option) {
    final isSelected = selectedValue == option.value;

    return GestureDetector(
      onTap: () => onChanged(option.value),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.grey[400]!,
                  width: 1,
                ),
                color: isSelected ? Colors.black : Colors.transparent,
              ),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                option.label,
                style: AppFonts.jostMedium.copyWith(
                  fontSize: 14,
                  color: isSelected ? Colors.black : AppColors.grey,
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
