import 'package:flutter/material.dart';
import 'package:fort_monitor/presentation/theme/app_colors.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';
import 'package:fort_monitor/presentation/widget/icons.dart' as custom_icons;
import 'package:fort_monitor/presentation/widget/inputs/custom_inputs.dart';
import 'package:fort_monitor/presentation/widget/default_button.dart';

class CustomSelect extends StatelessWidget {
  final String? label;
  final String? selectedValue;
  final String? hintText;
  final List<String> items;
  final Function(String?)? onChanged;
  final bool isRequired;
  final bool enabled;

  const CustomSelect({
    super.key,
    this.label,
    this.selectedValue,
    this.hintText,
    required this.items,
    this.onChanged,
    this.isRequired = false,
    this.enabled = true,
  });

  void _showModal(BuildContext context) {
    if (!enabled) return;

    showDialog(
      context: context,
      builder: (context) => _SelectModal(
        title: label ?? '',
        items: items,
        selectedValue: selectedValue,
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && label!.isNotEmpty)
          Text(
            label! + (isRequired ? ' *' : ''),
            style: AppFonts.jostSemiBold.copyWith(color: Colors.black87),
          ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showModal(context),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.greyCard,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedValue ?? hintText ?? 'Выберите значение',
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedValue != null
                          ? Colors.black
                          : Colors.grey.shade600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Transform.rotate(
                  angle: 0,
                  child: custom_icons.Icons(iconName: 'chevronBold', size: 8),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SelectModal extends StatefulWidget {
  final String title;
  final List<String> items;
  final String? selectedValue;
  final Function(String?)? onChanged;

  const _SelectModal({
    required this.title,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  State<_SelectModal> createState() => _SelectModalState();
}

class _SelectModalState extends State<_SelectModal> {
  String? tempSelectedValue;
  String searchQuery = '';
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    tempSelectedValue = widget.selectedValue;
    filteredItems = widget.items;
  }

  void _filterItems(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredItems = widget.items;
      } else {
        filteredItems = widget.items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _saveSelection() {
    widget.onChanged?.call(tempSelectedValue);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        decoration: const BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Text(
              widget.title.isEmpty ? 'Выбрать тс' : widget.title,
              style: AppFonts.jostMedium.copyWith(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 45),

            // Search
            CustomInput(
              hintText: 'поиск...',
              onChanged: _filterItems,
              controller: TextEditingController(),
              isRequired: false,
              enabled: true,
              type: InputType.text,
              textAlign: TextAlign.center,
              fontSize: 24,
              borderRadius: 100,
              height: 44,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  final isSelected = tempSelectedValue == item;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        tempSelectedValue = item;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isSelected
                            ? AppColors.greyCard
                            : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item,
                              style: AppFonts.jostRegular.copyWith(
                                fontSize: 20,
                                color: isSelected ? Colors.black : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            DefaultButton(onPressed: _saveSelection, text: 'Сохранить'),
          ],
        ),
      ),
    );
  }
}
