import 'package:flutter/material.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';
import 'package:fort_monitor/presentation/widget/default_button.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime? start, DateTime? end)? onDateRangeSelected;

  const CustomCalendar({
    super.key,
    this.startDate,
    this.endDate,
    this.onDateRangeSelected,
  });

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime focusedMonth;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  final List<String> weekDays = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];

  @override
  void initState() {
    super.initState();
    focusedMonth = DateTime.now();
    selectedStartDate = widget.startDate;
    selectedEndDate = widget.endDate;
  }

  bool isDateInRange(DateTime date) {
    if (selectedStartDate == null || selectedEndDate == null) return false;
    return date.isAfter(selectedStartDate!.subtract(const Duration(days: 1))) &&
        date.isBefore(selectedEndDate!.add(const Duration(days: 1)));
  }

  bool isMiddleDate(DateTime date) {
    if (selectedStartDate == null || selectedEndDate == null) return false;
    return date.isAfter(selectedStartDate!) && date.isBefore(selectedEndDate!);
  }

  BorderRadius getDateBorderRadius(DateTime date) {
    final isStart = isStartDate(date);
    final isEnd = isEndDate(date);
    final isMiddle = isMiddleDate(date);

    // Если выбрана только одна дата, применяем полное закругление
    if (selectedStartDate != null && selectedEndDate == null) {
      return BorderRadius.circular(8);
    }

    if (isStart) {
      return const BorderRadius.only(
        topLeft: Radius.circular(8),
        bottomLeft: Radius.circular(8),
      );
    } else if (isEnd) {
      return const BorderRadius.only(
        topRight: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    } else if (isMiddle) {
      return BorderRadius.zero;
    }

    return BorderRadius.circular(8);
  }

  Color getDateBackgroundColor(DateTime date) {
    final isStart = isStartDate(date);
    final isEnd = isEndDate(date);
    final isMiddle = isMiddleDate(date);

    if (isStart || isEnd) {
      return Colors.grey[300]!; // Темно-серый для начальной и конечной дат
    } else if (isMiddle) {
      return Colors.grey[100]!; // Светло-серый для дат между
    }

    return Colors.transparent;
  }

  bool isStartDate(DateTime date) {
    return selectedStartDate != null &&
        date.year == selectedStartDate!.year &&
        date.month == selectedStartDate!.month &&
        date.day == selectedStartDate!.day;
  }

  bool isEndDate(DateTime date) {
    return selectedEndDate != null &&
        date.year == selectedEndDate!.year &&
        date.month == selectedEndDate!.month &&
        date.day == selectedEndDate!.day;
  }

  void selectDate(DateTime date) {
    setState(() {
      if (selectedStartDate == null ||
          (selectedStartDate != null && selectedEndDate != null)) {
        selectedStartDate = date;
        selectedEndDate = null;
      } else {
        // Проверяем, что конечная дата не раньше начальной
        if (date.isBefore(selectedStartDate!)) {
          // Если выбрана дата раньше начальной, игнорируем выбор
          return;
        } else {
          selectedEndDate = date;
        }
      }
    });
  }

  String getMonthName(DateTime date) {
    const months = [
      'Январь',
      'Февраль',
      'Март',
      'Апрель',
      'Май',
      'Июнь',
      'Июль',
      'Август',
      'Сентябрь',
      'Октябрь',
      'Ноябрь',
      'Декабрь',
    ];
    return months[date.month - 1];
  }

  String getSelectedRangeText() {
    if (selectedStartDate == null) return 'Выбрать даты';
    if (selectedEndDate == null) {
      return 'Выбрать ${selectedStartDate!.day} ${getMonthName(selectedStartDate!).substring(0, 3).toLowerCase()}';
    }

    final startMonth = getMonthName(
      selectedStartDate!,
    ).substring(0, 3).toLowerCase();
    final endMonth = getMonthName(
      selectedEndDate!,
    ).substring(0, 3).toLowerCase();

    if (selectedStartDate!.month == selectedEndDate!.month) {
      return 'Выбрать ${selectedStartDate!.day} - ${selectedEndDate!.day} $startMonth';
    } else {
      return 'Выбрать ${selectedStartDate!.day} $startMonth - ${selectedEndDate!.day} $endMonth';
    }
  }

  List<DateTime> getDaysInMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);

    // Начинаем с понедельника недели, в которой находится первый день месяца
    final firstWeekday = firstDay.weekday;
    final startDate = firstDay.subtract(Duration(days: firstWeekday - 1));

    final days = <DateTime>[];

    // Добавляем ровно 6 недель (42 дня) для стабильного отображения
    for (int i = 0; i < 42; i++) {
      days.add(startDate.add(Duration(days: i)));
    }

    return days;
  }

  Widget buildMonthCalendar(DateTime month) {
    final days = getDaysInMonth(month);
    final isCurrentMonth =
        month.year == DateTime.now().year &&
        month.month == DateTime.now().month;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            '${getMonthName(month)} ${month.year}',
            style: AppFonts.jostMedium.copyWith(fontSize: 16),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
          ),
          itemCount: days.length,
          itemBuilder: (context, index) {
            final date = days[index];
            final isCurrentMonthDay = date.month == month.month;
            final isToday = isCurrentMonth && date.day == DateTime.now().day;
            final isSelected =
                isDateInRange(date) || isStartDate(date) || isEndDate(date);
            final isStart = isStartDate(date);
            final isEnd = isEndDate(date);

            // Проверяем, нужно ли затемнить дату (если выбрана начальная дата и текущая дата раньше)
            final shouldDarken =
                selectedStartDate != null &&
                selectedEndDate == null &&
                date.isBefore(selectedStartDate!);

            // Показываем только дни текущего месяца, остальные делаем прозрачными
            if (!isCurrentMonthDay) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                child: const SizedBox(),
              );
            }

            return GestureDetector(
              onTap: (isCurrentMonthDay && !shouldDarken)
                  ? () => selectDate(date)
                  : null,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(
                  color: isSelected
                      ? getDateBackgroundColor(date)
                      : isToday
                      ? Colors.grey[200]
                      : Colors.transparent,
                  borderRadius: getDateBorderRadius(date),
                ),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: AppFonts.jostRegular.copyWith(
                      fontSize: 14,
                      color: shouldDarken ? Colors.grey[400] : Colors.black,
                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Week days header
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: weekDays
                  .map(
                    (day) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: Text(
                            day,
                            style: AppFonts.jostRegular.copyWith(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildMonthCalendar(focusedMonth),
                  buildMonthCalendar(
                    DateTime(focusedMonth.year, focusedMonth.month + 1),
                  ),
                  buildMonthCalendar(
                    DateTime(focusedMonth.year, focusedMonth.month + 2),
                  ),
                  buildMonthCalendar(
                    DateTime(focusedMonth.year, focusedMonth.month + 3),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          selectedStartDate != null && selectedEndDate != null
              ? DefaultButton(
                  text: ' ${getSelectedRangeText()}',
                  onPressed: () {
                    widget.onDateRangeSelected?.call(
                      selectedStartDate,
                      selectedEndDate,
                    );
                    Navigator.of(context).pop();
                  },
                )
              : DefaultButton(
                  text: ' ${getSelectedRangeText()}',
                  onPressed: () {},
                ),
        ],
      ),
    );
  }
}
