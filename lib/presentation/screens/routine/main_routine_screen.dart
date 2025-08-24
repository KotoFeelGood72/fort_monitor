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
class MainRoutineScreen extends StatefulWidget {
  const MainRoutineScreen({super.key});

  @override
  State<MainRoutineScreen> createState() => _MainRoutineScreenState();
}

class _MainRoutineScreenState extends State<MainRoutineScreen> {
  // Controllers
  final checkboxController = ValueNotifier<bool>(false);

  // Form values
  String? selectedServiceType;
  String? selectedPartType;
  String? selectedBrand;
  String? selectedSize;
  String? selectedWarrantyType;
  String? selectedParameter;
  String? selectedFileName = 'Счет №935385.pdf';
  final List<String> parameters = ['Параметр 1', 'Параметр 2', 'Параметр 3'];
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'Регламентное обслуживание',
                style: AppFonts.jostRegular.copyWith(fontSize: 20),
              ),
            ),
            CustomRadioGroup(
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
            SizedBox(height: 12),
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
            SizedBox(height: 14),
            CustomTextarea(
              label: 'Наименование ГСМ, расходных материалов',
              controller: addressController,
              hintText: 'Наименование ГСМ, расходных материалов',
              isRequired: true,
              height: 131,
            ),
            SizedBox(height: 11),
            CustomTextarea(
              label: 'Какие работы выполнялись',
              controller: addressController,
              hintText: 'Какие работы выполнялись',
              isRequired: true,
              height: 131,
            ),
            SizedBox(height: 16),
            CustomInput(
              label: 'Стоимость работ по замене',
              type: InputType.text,
              controller: addressController,
              hintText: '',
              isRequired: true,
            ),
            SizedBox(height: 21),
            CustomCheckbox(
              label: 'добавлять в общую калькуляцию затрат ТС',
              controller: checkboxController,
              onChanged: (value) {
                print('Checkbox changed: $value');
              },
            ),
            SizedBox(height: 31),
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
            SizedBox(height: 24),

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
          ],
        ),
      ),
    );
  }
}
