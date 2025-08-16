import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fort_monitor/presentation/widget/app_layouts.dart';
import 'package:fort_monitor/presentation/widget/cards/report_card.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';

class ReportsItem {
  final String title;
  final String download;

  ReportsItem({required this.title, required this.download});
}

final List<ReportsItem> reportsItems = [
  ReportsItem(title: 'Регламентное обслуживание', download: ''),
  ReportsItem(title: 'Ремонт', download: ''),
  ReportsItem(title: 'Шины и диски', download: ''),
  ReportsItem(title: 'Заправки и пробег', download: ''),
];

@RoutePage()
class MainReportsScreen extends StatefulWidget {
  const MainReportsScreen({super.key});

  @override
  State<MainReportsScreen> createState() => _MainReportsScreenState();
}

class _MainReportsScreenState extends State<MainReportsScreen> {
  String? selectedParameter;

  final List<String> parameters = ['Параметр 1', 'Параметр 2', 'Параметр 3'];

  @override
  Widget build(BuildContext context) {
    return AppLayouts(
      headType: 'single',
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 32, bottom: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Отчеты по автомобилю',
                  style: AppFonts.jostRegular.copyWith(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: reportsItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: ReportCard(
                      title: item.title,
                      onTap: () {},
                      // onTap: () => context.router.push(
                      // SingleRoutineScreenRoute(id: item.link),
                      // ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
