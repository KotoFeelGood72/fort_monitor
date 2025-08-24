import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fort_monitor/presentation/widget/app_layouts.dart';
import 'package:fort_monitor/presentation/widget/inputs/custom_inputs.dart';
import 'package:fort_monitor/presentation/widget/inputs/custom_file_upload.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';
import 'package:fort_monitor/presentation/widget/save_button.dart';

@RoutePage()
class MainStationsScreen extends StatefulWidget {
  const MainStationsScreen({super.key});

  @override
  State<MainStationsScreen> createState() => _MainStationsScreenState();
}

class _MainStationsScreenState extends State<MainStationsScreen> {
  // Контроллеры для инпутов заправки
  final refuelingPeriodController = TextEditingController();
  final refuelingCountController = TextEditingController();
  final fuelPriceController = TextEditingController();
  final totalLitersController = TextEditingController();

  // Контроллеры для инпутов пробега
  final mileagePeriodController = TextEditingController();
  final totalMileageController = TextEditingController();
  final costPerKmController = TextEditingController();

  // Контроллеры для инпутов общих затрат
  final totalCostsPeriodController = TextEditingController();
  final totalCostsController = TextEditingController();

  // Контроллер для файла
  String? selectedFileName;

  @override
  void dispose() {
    refuelingPeriodController.dispose();
    refuelingCountController.dispose();
    fuelPriceController.dispose();
    totalLitersController.dispose();
    mileagePeriodController.dispose();
    totalMileageController.dispose();
    costPerKmController.dispose();
    totalCostsPeriodController.dispose();
    totalCostsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayouts(
      headType: 'single',
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 19),
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
            Container(
              padding: EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Color(0xFFFEFEFE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  CustomDateInput(
                    label: 'Выбрать период',
                    controller: refuelingPeriodController,
                    hintText: 'Выберите период',
                    onDateRangeSelected: (start, end) {
                      print('Refueling period selected: $start - $end');
                    },
                  ),
                  SizedBox(height: 28),
                  CustomInput(
                    label: 'Количество заправок',
                    type: InputType.text,
                    controller: refuelingCountController,
                    hintText: '',
                    isRequired: true,
                  ),
                  SizedBox(height: 15),
                  CustomInput(
                    label: 'Стоимость 1 литра*',
                    type: InputType.text,
                    controller: fuelPriceController,
                    hintText: '',
                    isRequired: true,
                  ),
                  SizedBox(height: 15),
                  CustomInput(
                    label: 'Общее количество заправленных литров',
                    type: InputType.text,
                    controller: totalLitersController,
                    hintText: '',
                    isRequired: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 33),
            Container(
              padding: EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Color(0xFFFEFEFE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Общее количество пробега',
                      style: AppFonts.jostMedium.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 13),
                  CustomDateInput(
                    label: 'Выбрать период',
                    controller: mileagePeriodController,
                    hintText: 'Выберите период',
                    onDateRangeSelected: (start, end) {
                      print('Mileage period selected: $start - $end');
                    },
                  ),
                  SizedBox(height: 18),
                  CustomInput(
                    type: InputType.text,
                    controller: totalMileageController,
                    hintText: '',
                    isRequired: true,
                  ),
                  SizedBox(height: 15),
                  CustomInput(
                    label: 'Затраты на 1 км',
                    type: InputType.text,
                    controller: costPerKmController,
                    hintText: '',
                    isRequired: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 33),
            Container(
              padding: EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Color(0xFFFEFEFE),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Общие затраты за выбранный период',
                      style: AppFonts.jostMedium.copyWith(fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 13),
                  CustomDateInput(
                    label: 'Выбрать период',
                    controller: totalCostsPeriodController,
                    hintText: 'Выберите период',
                    onDateRangeSelected: (start, end) {
                      print('Total costs period selected: $start - $end');
                    },
                  ),
                  SizedBox(height: 18),
                  CustomInput(
                    type: InputType.text,
                    controller: totalCostsController,
                    hintText: '',
                    isRequired: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 33),

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
