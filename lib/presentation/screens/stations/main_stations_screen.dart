import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fort_monitor/presentation/widget/app_layouts.dart';
import 'package:fort_monitor/presentation/widget/inputs/custom_inputs.dart';
import 'package:fort_monitor/presentation/widget/inputs/custom_selects.dart';
import 'package:fort_monitor/presentation/widget/inputs/custom_file_upload.dart';
import 'package:fort_monitor/presentation/widget/inputs/custom_checkbox.dart';
import 'package:fort_monitor/presentation/widget/inputs/custom_radio_group.dart';
import 'package:fort_monitor/presentation/widget/inputs/custom_warranty_counter.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';
import 'package:fort_monitor/presentation/widget/save_button.dart';

@RoutePage()
class MainStationsScreen extends StatefulWidget {
  const MainStationsScreen({super.key});

  @override
  State<MainStationsScreen> createState() => _MainStationsScreenState();
}

class _MainStationsScreenState extends State<MainStationsScreen> {
  // Controllers
  final checkboxController = ValueNotifier<bool>(false);

  // Form values
  String? selectedServiceType;
  String? selectedPartType;
  String? selectedBrand;
  String? selectedSize;
  String? selectedWarrantyType;
  String? selectedFileName = 'Счет №935385.pdf';
  Map<String, Map<String, String>> warrantyValues = {
    'spare_part': {
      'label': 'Гарантийный счетчик запасной части',
      'hour': '14',
      'month': '03',
      'year': '27',
    },
    'completed_works': {
      'label': 'Гарантийный счетчик на выполненные работы',
      'hour': '',
      'month': '',
      'year': '',
    },
  };

  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final costController = TextEditingController();
  final workCostController = TextEditingController();
  final dateController = TextEditingController();
  final recipientNameController = TextEditingController();
  final recipientPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedServiceType = 'sto';
    phoneController.text = '+79000000000';
    addressController.text = 'Садовая, д. 5, корп. 16';
    costController.text = '15000';
    workCostController.text = '2000';
    dateController.text = '15.04.2025';
    recipientNameController.text = 'Иванов Иван Иванович';
    recipientPhoneController.text = '+79000000000';
  }

  @override
  void dispose() {
    checkboxController.dispose();
    phoneController.dispose();
    addressController.dispose();
    costController.dispose();
    workCostController.dispose();
    dateController.dispose();
    recipientNameController.dispose();
    recipientPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayouts(
      headType: 'single',
      title: 'TC ',
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'Заправки и пробег',
                style: AppFonts.jostRegular.copyWith(fontSize: 20),
              ),
            ),
            CustomDateInput(
              label: 'Выбрать период',
              controller: dateController,
              hintText: 'Выберите период',
              onDateRangeSelected: (start, end) {
                print('Date range selected: $start - $end');
              },
            ),
            SizedBox(height: 20),
            CustomInput(
              label: 'Наименование детали ',
              type: InputType.text,
              controller: addressController,
              hintText: '',
              isRequired: true,
            ),
            SizedBox(height: 10),
            CustomInput(
              label: 'Номенклатурный номер',
              type: InputType.text,
              controller: addressController,
              hintText: '',
              isRequired: true,
            ),
            SizedBox(height: 10),
            CustomInput(
              label: 'Стоимость',
              type: InputType.text,
              controller: addressController,
              hintText: '',
              isRequired: true,
            ),
            SizedBox(height: 10),
            CustomInput(
              label: 'Стоимость работ по замене',
              type: InputType.text,
              controller: addressController,
              hintText: '',
              isRequired: true,
            ),
            SizedBox(height: 22),
            CustomCheckbox(
              label: 'добавлять в общую калькуляцию затрат ТС',
              controller: checkboxController,
              onChanged: (value) {
                print('Checkbox changed: $value');
              },
            ),
            SizedBox(height: 34),
            CustomRadioGroup(
              label: 'Тип сервиса',
              selectedValue: selectedServiceType,
              onChanged: (value) {
                setState(() {
                  selectedServiceType = value;
                });
              },
              options: const [
                RadioOption(label: 'СТО', value: 'sto'),
                RadioOption(label: 'Сервисный центр', value: 'service_center'),
                RadioOption(label: 'Выездной специалист', value: 'out'),
              ],
            ),
            SizedBox(height: 21),
            CustomInput(
              label: '',
              type: InputType.text,
              controller: addressController,
              hintText: '',
            ),
            SizedBox(height: 17),
            CustomInput(
              label: 'Номер телефона',
              type: InputType.phone,
              controller: phoneController,
              hintText: '+7 (___) ___-__-__',
              isRequired: true,
            ),
            SizedBox(height: 10),
            CustomInput(
              label: 'Адрес',
              type: InputType.text,
              controller: addressController,
              hintText: 'Введите адрес',
              isRequired: true,
            ),
            SizedBox(height: 10),
            CustomInput(
              label: 'Дата замены',
              type: InputType.date,
              controller: dateController,
              hintText: 'ДД.ММ.ГГГГ',
              isRequired: true,
            ),
            SizedBox(height: 10),
            CustomInput(
              label: 'ФИО принимающего',
              type: InputType.text,
              controller: recipientNameController,
              hintText: 'Введите ФИО',
              isRequired: true,
            ),
            SizedBox(height: 10),
            CustomInput(
              label: 'Телефон принимающего',
              type: InputType.phone,
              controller: recipientPhoneController,
              hintText: '+7 (___) ___-__-__',
              isRequired: true,
            ),
            SizedBox(height: 32),
            CustomWarrantyCounter(
              selectedType: selectedWarrantyType,
              warrantyValues: warrantyValues,
              onTypeChanged: (type) {
                setState(() {
                  selectedWarrantyType = type;
                });
                print('Warranty type changed: $type');
              },
              onValuesChanged: (type, hour, month) {
                setState(() {
                  warrantyValues[type]?['hour'] = hour;
                  warrantyValues[type]?['month'] = month;
                });
                print('Warranty values changed: $type - $hour:$month');
              },
            ),
            SizedBox(height: 10),

            // File Upload
            CustomFileUpload(
              label: 'Прикрепить файл',
              fileName: selectedFileName,
              onFileSelected: (file) {
                setState(() {
                  selectedFileName = file.name;
                });
                print('File selected: ${file.name}');
              },
              onFileRemoved: () {
                setState(() {
                  selectedFileName = null;
                });
                print('File removed');
              },
              isRequired: true,
            ),
            SizedBox(height: 34),

            SaveButton(
              onPressed: () {
                print('Form saved');
              },
            ),
            SizedBox(height: 68),
          ],
        ),
      ),
    );
  }
}
