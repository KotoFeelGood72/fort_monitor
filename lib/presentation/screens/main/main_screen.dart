import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fort_monitor/presentation/utils/vehicle_storage.dart';
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
  MainItem(title: 'Регламентное обслуживание', route: 'routine'),
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
  String? selectedVehicle;
  bool _isLoading = true;

  final List<String> vehicles = [
    'ТС C978MK',
    'ТС A123BC',
    'ТС B456DE',
    'ТС C789FG',
    'ТС D012HI',
    'ТС E345JK',
    'ТС F678LM',
    'ТС G901NO',
  ];

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      await VehicleStorage.initialize();
      await _loadSelectedVehicle();
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

  Future<void> _loadSelectedVehicle() async {
    try {
      final vehicle = await VehicleStorage.getSelectedVehicle();
      if (vehicle != null && mounted) {
        setState(() {
          selectedVehicle = vehicle;
        });
      }
    } catch (e) {
      debugPrint('Ошибка загрузки автомобиля: $e');
    }
  }

  Future<void> _saveSelectedVehicle(String vehicle) async {
    try {
      await VehicleStorage.setSelectedVehicle(vehicle);
    } catch (e) {
      debugPrint('Ошибка сохранения автомобиля: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return AppLayouts(
      headType: 'default',
      title: 'Название',
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
                selectedValue: selectedVehicle,
                hintText: 'Выберите ТС',
                items: vehicles,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      selectedVehicle = value;
                    });
                    _saveSelectedVehicle(value);
                  }
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
                            context.router.push(MainCareScreenRoute());
                            break;
                          case 'repair':
                            context.router.push(MainRepairScreenRoute());
                            break;
                          case 'routine':
                            context.router.push(MainRoutineScreenRoute());
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
