import 'package:flutter/material.dart';
import 'package:fort_monitor/presentation/utils/vehicle_storage.dart';

/// Пример использования VehicleStorage в других экранах
class VehicleStorageExample {
  
  /// Пример получения выбранного автомобиля в любом экране
  static Future<String> getVehicleTitle() async {
    return await VehicleStorage.getSelectedVehicleWithFallback(fallback: 'ТС');
  }
  
  /// Пример использования в StatefulWidget
  static Future<String> loadVehicleInWidget() async {
    try {
      return await VehicleStorage.getSelectedVehicleWithFallback();
    } catch (e) {
      debugPrint('Ошибка загрузки автомобиля: $e');
      return 'ТС';
    }
  }
  
  /// Пример использования в StatelessWidget
  static FutureBuilder<String> buildVehicleTitle() {
    return FutureBuilder<String>(
      future: VehicleStorage.getSelectedVehicleWithFallback(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Загрузка...');
        }
        
        if (snapshot.hasError) {
          return const Text('ТС');
        }
        
        return Text(snapshot.data ?? 'ТС');
      },
    );
  }
}

/// Пример виджета, использующего VehicleStorage
class ExampleVehicleWidget extends StatefulWidget {
  const ExampleVehicleWidget({super.key});

  @override
  State<ExampleVehicleWidget> createState() => _ExampleVehicleWidgetState();
}

class _ExampleVehicleWidgetState extends State<ExampleVehicleWidget> {
  String? selectedVehicle;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVehicle();
  }

  Future<void> _loadVehicle() async {
    try {
      final vehicle = await VehicleStorage.getSelectedVehicleWithFallback();
      if (mounted) {
        setState(() {
          selectedVehicle = vehicle;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          selectedVehicle = 'ТС';
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }
    
    return Text(selectedVehicle ?? 'ТС');
  }
}
