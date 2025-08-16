import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fort_monitor/presentation/widget/app_layouts.dart';
import 'package:fort_monitor/presentation/widget/cards/default_card.dart';
import 'package:fort_monitor/presentation/router/app_router.dart';
import 'package:fort_monitor/presentation/widget/inputs/custom_selects.dart';

import 'package:fort_monitor/presentation/theme/app_fonts.dart';

class MainItem {
  final String title;
  final String route;

  MainItem({required this.title, required this.route});
}

final List<MainItem> mainItems = [
  MainItem(title: 'Регламентное обслуживание', route: 'care'),
  MainItem(title: 'Ремонт', route: 'repair'),
  MainItem(title: 'Замена запасных частей', route: 'parts'),
  MainItem(title: 'Шины и диски', route: 'tires'),
  MainItem(title: 'Уход за авто', route: 'care'),
  MainItem(title: 'Заправки и пробег', route: 'refueling'),
  MainItem(title: 'Отчеты', route: 'reports'),
];

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? selectedParameter;

  final List<String> parameters = ['Параметр 1', 'Параметр 2', 'Параметр 3'];

  @override
  Widget build(BuildContext context) {
    return AppLayouts(
      headType: 'default',
      title: 'ООО Название',
      body: Container(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 32, bottom: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Наименование ТС',
                style: AppFonts.jostMedium.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 8),
              CustomSelect(
                selectedValue: selectedParameter,
                hintText: 'Выберите параметр',
                items: parameters,
                onChanged: (String? value) {
                  setState(() {
                    selectedParameter = value;
                  });
                },
              ),
              SizedBox(height: 38),
              Column(
                children: mainItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: DefaultCard(
                      title: item.title,
                      onTap: () {
                        switch (item.route) {
                          case 'care':
                            context.router.push(MainRoutineScreenRoute());
                            break;
                          case 'repair':
                            context.router.push(MainRepairScreenRoute());
                            break;
                          case 'parts':
                            context.router.push(MainPartsScreenRoute());
                            break;
                          case 'tires':
                            context.router.push(MainTiresScreenRoute());
                            break;
                          case 'refueling':
                            context.router.push(MainStationsScreenRoute());
                            break;
                          case 'reports':
                            context.router.push(MainReportsScreenRoute());
                            break;
                          default:
                            context.router.push(MainCareScreenRoute());
                        }
                      },
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
