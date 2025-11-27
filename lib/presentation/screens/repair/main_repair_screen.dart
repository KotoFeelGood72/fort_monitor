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
class MainRepairScreen extends StatefulWidget {
  const MainRepairScreen({super.key});

  @override
  State<MainRepairScreen> createState() => _MainRepairScreenState();
}

class _MainRepairScreenState extends State<MainRepairScreen> {
  // Controllers
  final checkboxController = ValueNotifier<bool>(false);

  // Form values
  String? selectedServiceType;
  String? selectedWarrantyType;
  String? selectedFileName = '';
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

  // Text controllers
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final workDescriptionController = TextEditingController();
  final workCostController = TextEditingController();
  final dateController = TextEditingController();
  final recipientNameController = TextEditingController();
  final recipientPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedServiceType = 'sto';
  }

  @override
  void dispose() {
    checkboxController.dispose();
    phoneController.dispose();
    addressController.dispose();
    workDescriptionController.dispose();
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
                'Ремонт',
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
            SizedBox(height: 21),
            CustomInput(
              label: 'Номер телефона',
              type: InputType.phone,
              controller: phoneController,
              hintText: '+7 (___) ___-__-__',
              isRequired: true,
            ),
            SizedBox(height: 15),
            CustomInput(
              label: 'Адрес',
              type: InputType.text,
              controller: addressController,
              hintText: 'Введите адрес',
              isRequired: true,
            ),
            SizedBox(height: 15),
            CustomTextarea(
              label: 'Какие работы выполнялись',
              controller: workDescriptionController,
              hintText: 'Опишите выполненные работы',
              isRequired: true,
              height: 120,
            ),
            SizedBox(height: 15),
            CustomInput(
              label: 'Стоимость работ',
              type: InputType.text,
              controller: workCostController,
              hintText: '',
              isRequired: true,
            ),
            SizedBox(height: 15),
            CustomCheckbox(
              label: 'добавлять в общую калькуляцию затрат ТС',
              controller: checkboxController,
              onChanged: (value) {
                print('Checkbox changed: $value');
              },
            ),
            SizedBox(height: 32),
            CustomInput(
              label: 'Дата',
              type: InputType.date,
              controller: dateController,
              hintText: 'ДД.ММ.ГГГГ',
              isRequired: true,
            ),
            SizedBox(height: 15),
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
