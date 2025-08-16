import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class VehicleStorage {
  static const String _selectedVehicleKey = 'selected_vehicle';
  static bool _useSharedPreferences = true;
  
  // Простое in-memory хранилище как fallback
  static final Map<String, String> _memoryStorage = {};

  /// Инициализация SharedPreferences
  static Future<void> initialize() async {
    try {
      await SharedPreferences.getInstance();
      _useSharedPreferences = true;
    } catch (e) {
      debugPrint('Ошибка SharedPreferences, переключаемся на in-memory хранилище: $e');
      _useSharedPreferences = false;
    }
  }

  /// Получить выбранное транспортное средство
  static Future<String?> getSelectedVehicle() async {
    if (!_useSharedPreferences) {
      return _memoryStorage[_selectedVehicleKey];
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_selectedVehicleKey);
    } catch (e) {
      debugPrint('Ошибка загрузки из SharedPreferences: $e');
      _useSharedPreferences = false;
      return _memoryStorage[_selectedVehicleKey];
    }
  }

  /// Сохранить выбранное транспортное средство
  static Future<void> setSelectedVehicle(String vehicle) async {
    if (!_useSharedPreferences) {
      _memoryStorage[_selectedVehicleKey] = vehicle;
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_selectedVehicleKey, vehicle);
    } catch (e) {
      debugPrint('Ошибка сохранения в SharedPreferences, переключаемся на in-memory: $e');
      _useSharedPreferences = false;
      _memoryStorage[_selectedVehicleKey] = vehicle;
    }
  }

  /// Получить выбранное транспортное средство с fallback значением
  static Future<String> getSelectedVehicleWithFallback({String fallback = 'ТС'}) async {
    final vehicle = await getSelectedVehicle();
    return vehicle ?? fallback;
  }

  /// Проверить, используется ли SharedPreferences
  static bool get isUsingSharedPreferences => _useSharedPreferences;
}
