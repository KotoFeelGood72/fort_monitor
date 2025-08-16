import 'package:flutter/material.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';
import 'package:fort_monitor/presentation/widget/icons.dart' as custom_icons;
import 'package:fort_monitor/presentation/widget/inputs/custom_calendar.dart';

class CustomDatePeriodInput extends StatelessWidget {
  final String label;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime? start, DateTime? end)? onDateRangeSelected;

  const CustomDatePeriodInput({
    super.key,
    required this.label,
    this.startDate,
    this.endDate,
    this.onDateRangeSelected,
  });

  String getDisplayText() {
    if (startDate == null && endDate == null) {
      return 'Выберите период';
    }
    if (startDate != null && endDate == null) {
      return '${startDate!.day.toString().padLeft(2, '0')}.${startDate!.month.toString().padLeft(2, '0')}.${startDate!.year}';
    }
    if (startDate != null && endDate != null) {
      return '${startDate!.day.toString().padLeft(2, '0')}.${startDate!.month.toString().padLeft(2, '0')}.${startDate!.year} - ${endDate!.day.toString().padLeft(2, '0')}.${endDate!.month.toString().padLeft(2, '0')}.${endDate!.year}';
    }
    return 'Выберите период';
  }

  void _showCalendar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: CustomCalendar(
          startDate: startDate,
          endDate: endDate,
          onDateRangeSelected: (start, end) {
            onDateRangeSelected?.call(start, end);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Label слева
        Text(
          label,
          style: AppFonts.jostMedium.copyWith(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 16),

        // Input с датой и иконкой
        Expanded(
          child: GestureDetector(
            onTap: () => _showCalendar(context),
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.greyCard,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  // Дата в центре
                  Expanded(
                    child: Text(
                      getDisplayText(),
                      style: AppFonts.jostRegular.copyWith(
                        fontSize: 16,
                        color: (startDate != null || endDate != null)
                            ? Colors.black
                            : Colors.grey[600],
                      ),
                    ),
                  ),

                  // Иконка справа
                  custom_icons.Icons(iconName: 'datePicker', size: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
