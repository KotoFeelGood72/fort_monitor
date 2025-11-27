import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fort_monitor/presentation/utils/vehicle_storage.dart';
import 'package:fort_monitor/presentation/widget/app_layouts.dart';
import 'package:fort_monitor/presentation/widget/inputs/custom_inputs.dart';
import 'package:fort_monitor/presentation/widget/inputs/custom_file_upload.dart';
import 'package:fort_monitor/presentation/widget/inputs/custom_checkbox.dart';
import 'package:fort_monitor/presentation/widget/inputs/custom_warranty_counter.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';
import 'package:fort_monitor/presentation/widget/save_button.dart';

@RoutePage()
class MainPartsScreen extends StatefulWidget {
  const MainPartsScreen({super.key});

  @override
  State<MainPartsScreen> createState() => _MainPartsScreenState();
}

class _MainPartsScreenState extends State<MainPartsScreen> {
  // Controllers
  final checkboxController = ValueNotifier<bool>(false);

  // Vehicle storage variables
  bool _isLoading = true;

  // Form values
  String? selectedServiceType;
  String? selectedPartType;
  String? selectedBrand;
  String? selectedSize;
  String? selectedWarrantyType;
  String? selectedFileName = '';
  String serviceTypeInputValue = 'СТО';
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

  // Controllers for each input
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dateController = TextEditingController();
  final recipientNameController = TextEditingController();
  final recipientPhoneController = TextEditingController();

  // New controllers for parts screen
  final partNameController = TextEditingController();
  final partNumberController = TextEditingController();
  final partCostController = TextEditingController();
  final replacementWorkCostController = TextEditingController();
  final serviceTypeInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedServiceType = 'sto';

    // Initialize controllers with empty values
    phoneController.text = '';
    addressController.text = '';
    dateController.text = '';
    recipientNameController.text = '';
    recipientPhoneController.text = '';

    // Initialize new controllers
    partNameController.text = '';
    partNumberController.text = '';
    partCostController.text = '';
    replacementWorkCostController.text = '';
    serviceTypeInputValue = 'СТО';

    // Initialize SharedPreferences
    _initializeApp();
  }

  @override
  void dispose() {
    checkboxController.dispose();
    phoneController.dispose();
    addressController.dispose();
    dateController.dispose();
    recipientNameController.dispose();
    recipientPhoneController.dispose();

    // Dispose new controllers
    partNameController.dispose();
    partNumberController.dispose();
    partCostController.dispose();
    replacementWorkCostController.dispose();
    serviceTypeInputController.dispose();
    super.dispose();
  }

  // Method to update service type text based on radio selection
  void _updateServiceTypeText(String? value) {
    setState(() {
      selectedServiceType = value;
      switch (value) {
        case 'sto':
          serviceTypeInputValue = 'СТО';
          break;
        case 'service_center':
          serviceTypeInputValue = 'Сервисный центр';
          break;
        case 'out':
          serviceTypeInputValue = 'Выездной специалист';
          break;
        default:
          serviceTypeInputValue = '';
      }
    });
  }

  // Vehicle storage methods
  Future<void> _initializeApp() async {
    try {
      await VehicleStorage.initialize();
    } catch (e) {
      debugPrint('Ошибка инициализации VehicleStorage: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
                'Замена запасных частей',
                style: AppFonts.jostRegular.copyWith(fontSize: 20),
              ),
            ),
            CustomInput(
              label: 'Наименование детали',
              type: InputType.text,
              controller: partNameController,
              hintText: '',
              isRequired: true,
            ),
            SizedBox(height: 10),
            CustomInput(
              label: 'Номенклатурный номер',
              type: InputType.text,
              controller: partNumberController,
              hintText: '',
              isRequired: true,
            ),
            SizedBox(height: 10),
            CustomInput(
              label: 'Стоимость',
              type: InputType.text,
              controller: partCostController,
              hintText: '',
              isRequired: true,
            ),
            SizedBox(height: 10),
            CustomInput(
              label: 'Стоимость работ',
              type: InputType.text,
              controller: replacementWorkCostController,
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
              onChanged: _updateServiceTypeText,
              showInput: true,
              inputHint: 'Введите дополнительную информацию',
              inputController: serviceTypeInputController,
              onInputChanged: (value) {
                print('Input changed: $value');
              },
              options: const [
                RadioOption(label: 'СТО', value: 'sto'),
                RadioOption(label: 'Сервисный центр', value: 'service_center'),
                RadioOption(label: 'Выездной специалист', value: 'out'),
              ],
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
              label: 'Дата',
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
              showOnlyKeys: ['spare_part', 'completed_works'],
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
