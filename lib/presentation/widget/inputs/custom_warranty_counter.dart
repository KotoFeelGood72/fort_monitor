import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';

/// Виджет для отображения счетчиков гарантии
///
/// Параметр [showOnlyKeys] позволяет фильтровать отображаемые счетчики:
/// - `null` или пустой массив - показывать все счетчики
/// - `['completed_works']` - показывать только "Гарантийный счетчик на выполненные работы"
/// - `['spare_part']` - показывать только "Гарантийный счетчик запасной части"
/// - `['spare_part', 'completed_works']` - показывать оба счетчика
class CustomWarrantyCounter extends StatefulWidget {
  final String? selectedType;
  final Function(String?)? onTypeChanged;
  final Map<String, Map<String, String>> warrantyValues;
  final Function(String, String, String)? onValuesChanged;
  final bool single;
  final List<String>? showOnlyKeys;

  const CustomWarrantyCounter({
    super.key,
    this.selectedType,
    this.onTypeChanged,
    required this.warrantyValues,
    this.onValuesChanged,
    this.single = false,
    this.showOnlyKeys,
  });

  @override
  State<CustomWarrantyCounter> createState() => _CustomWarrantyCounterState();
}

class _CustomWarrantyCounterState extends State<CustomWarrantyCounter> {
  final Map<String, List<TextEditingController>> controllers = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    for (String type in widget.warrantyValues.keys) {
      controllers[type] = [
        TextEditingController(text: widget.warrantyValues[type]?['hour'] ?? ''),
        TextEditingController(
          text: widget.warrantyValues[type]?['month'] ?? '',
        ),
        TextEditingController(text: widget.warrantyValues[type]?['year'] ?? ''),
      ];
    }
  }

  @override
  void dispose() {
    for (var controllerList in controllers.values) {
      for (var controller in controllerList) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  void _onTypeChanged(String? type) {
    if (widget.single) {
      // В режиме single работаем как чекбокс
      final newType = widget.selectedType == type ? null : type;
      widget.onTypeChanged?.call(newType);
    } else {
      // Обычный режим radio
      widget.onTypeChanged?.call(type);
    }
  }

  void _onValueChanged(String type, int index, String value) {
    if (widget.onValuesChanged != null) {
      final currentValues = Map<String, String>.from(
        widget.warrantyValues[type] ?? {},
      );
      final labels = ['hour', 'month', 'year'];
      currentValues[labels[index]] = value;
      widget.onValuesChanged!(
        type,
        currentValues['hour'] ?? '',
        currentValues['month'] ?? '',
      );
    }
  }

  Widget _buildTimeInputs(String type, String label) {
    final isSelected = widget.selectedType == type;
    final typeControllers = controllers[type] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 21,
      children: [
        Row(
          spacing: 7,
          children: [
            GestureDetector(
              onTap: () => _onTypeChanged(type),
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.black : AppColors.grey,
                    width: 1,
                  ),
                  color: isSelected ? Colors.black : Colors.transparent,
                ),
              ),
            ),
            Expanded(
              child: Text(
                label,
                style: AppFonts.jostMedium.copyWith(
                  fontSize: 14,
                  color: isSelected ? Colors.black : AppColors.grey,
                ),
              ),
            ),
          ],
        ),
        Row(
          spacing: 45,
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 49,
                          width: 42,
                          decoration: BoxDecoration(
                            color: AppColors.greyCard,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: typeControllers.isNotEmpty
                                ? typeControllers[0]
                                : null,
                            enabled: isSelected,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            onChanged: (value) =>
                                _onValueChanged(type, 0, value),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          height: 49,
                          width: 42,
                          decoration: BoxDecoration(
                            color: AppColors.greyCard,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: typeControllers.length > 1
                                ? typeControllers[1]
                                : null,
                            enabled: isSelected,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            onChanged: (value) =>
                                _onValueChanged(type, 1, value),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'час',
                    style: AppFonts.jostMedium.copyWith(
                      color: AppColors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Month inputs
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 49,
                          width: 42,
                          decoration: BoxDecoration(
                            color: AppColors.greyCard,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: typeControllers.length > 2
                                ? typeControllers[2]
                                : null,
                            enabled: isSelected,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            onChanged: (value) =>
                                _onValueChanged(type, 2, value),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          height: 49,
                          width: 42,
                          decoration: BoxDecoration(
                            color: AppColors.greyCard,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: typeControllers.length > 3
                                ? typeControllers[3]
                                : null,
                            enabled: isSelected,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            onChanged: (value) =>
                                _onValueChanged(type, 3, value),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'месяц',
                    style: AppFonts.jostMedium.copyWith(
                      color: AppColors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Year inputs
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 49,
                          width: 42,
                          decoration: BoxDecoration(
                            color: AppColors.greyCard,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: typeControllers.length > 4
                                ? typeControllers[4]
                                : null,
                            enabled: isSelected,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            onChanged: (value) =>
                                _onValueChanged(type, 4, value),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          height: 49,
                          width: 42,
                          decoration: BoxDecoration(
                            color: AppColors.greyCard,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: typeControllers.length > 5
                                ? typeControllers[5]
                                : null,
                            enabled: isSelected,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            onChanged: (value) =>
                                _onValueChanged(type, 5, value),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'год',
                    style: AppFonts.jostMedium.copyWith(
                      color: AppColors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Фильтруем записи в зависимости от параметра showOnlyKeys
    final filteredEntries = widget.warrantyValues.entries.where((entry) {
      if (widget.showOnlyKeys != null && widget.showOnlyKeys!.isNotEmpty) {
        // Показываем только указанные ключи
        return widget.showOnlyKeys!.contains(entry.key);
      }
      // Показываем все записи
      return true;
    }).toList();

    return Column(
      children: filteredEntries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 17),
          child: _buildTimeInputs(entry.key, entry.value['label'] ?? entry.key),
        );
      }).toList(),
    );
  }
}
