import 'package:flutter/material.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';
import 'package:fort_monitor/presentation/widget/inputs/custom_calendar.dart';

class CustomDateInput extends StatefulWidget {
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

  @override
  State<CustomDateInput> createState() => _CustomDateInputState();
}

class _CustomDateInputState extends State<CustomDateInput> {
  String _getDisplayText() {
    // Если есть текст в контроллере, показываем его
    if (widget.controller?.text.isNotEmpty == true) {
      return widget.controller!.text;
    }

    // Если есть начальное значение, показываем его
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      return widget.initialValue!;
    }

    // Если есть startDate и endDate, форматируем их
    if (widget.startDate != null && widget.endDate != null) {
      final startStr =
          '${widget.startDate!.day.toString().padLeft(2, '0')}.${widget.startDate!.month.toString().padLeft(2, '0')}.${widget.startDate!.year}';
      final endStr =
          '${widget.endDate!.day.toString().padLeft(2, '0')}.${widget.endDate!.month.toString().padLeft(2, '0')}.${widget.endDate!.year}';
      return '$startStr - $endStr';
    }

    // Если есть только startDate, показываем его
    if (widget.startDate != null) {
      final startStr =
          '${widget.startDate!.day.toString().padLeft(2, '0')}.${widget.startDate!.month.toString().padLeft(2, '0')}.${widget.startDate!.year}';
      return startStr;
    }

    // По умолчанию показываем hintText
    return widget.hintText ?? 'Выберите дату';
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
          startDate: widget.startDate,
          endDate: widget.endDate,
          onDateRangeSelected: (start, end) {
            widget.onDateRangeSelected?.call(start, end);
            if (widget.controller != null && start != null && end != null) {
              final startStr =
                  '${start.day.toString().padLeft(2, '0')}.${start.month.toString().padLeft(2, '0')}.${start.year}';
              final endStr =
                  '${end.day.toString().padLeft(2, '0')}.${end.month.toString().padLeft(2, '0')}.${end.year}';
              widget.controller!.text = '$startStr - $endStr';
              setState(() {});
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 15,
      children: [
        if (widget.label.isNotEmpty)
          Text(
            widget.label + (widget.isRequired ? ' *' : ''),
            style: AppFonts.jostMedium.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        Expanded(
          child: GestureDetector(
            onTap: widget.enabled
                ? () {
                    if (widget.onTap != null) {
                      widget.onTap!();
                    } else {
                      _showCalendarModal(context);
                    }
                  }
                : null,
            child: Container(
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.greyCard,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          _getDisplayText(),
                          style: AppFonts.jostRegular.copyWith(
                            fontSize: 14,
                            color:
                                _getDisplayText() !=
                                    (widget.hintText ?? 'Выберите дату')
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/date_picker.png',
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
