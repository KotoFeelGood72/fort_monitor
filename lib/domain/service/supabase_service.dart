import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class SupabaseService {
  static const String _supabaseUrl = 'https://difqshdstbudtgiwyjhn.supabase.co';
  static const String _supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRpZnFzaGRzdGJ1ZHRnaXd5amhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU4NjMyMTAsImV4cCI6MjA3MTQzOTIxMH0.VyqTult5rQEWTJrzpKjS1QkugstBVlQO2LuNU9OtrZw';

  static SupabaseClient get client => Supabase.instance.client;

  // Инициализация Supabase с обработкой ошибок
  static Future<void> initialize() async {
    try {
      debugPrint('Инициализация Supabase...');
      debugPrint('URL: $_supabaseUrl');

      await Supabase.initialize(
        url: _supabaseUrl,
        anonKey: _supabaseAnonKey,
        authOptions: const FlutterAuthClientOptions(
          authFlowType: AuthFlowType.pkce,
        ),
      );

      debugPrint('Supabase успешно инициализирован');

      // Проверяем доступность сервера
      await _checkServerAvailability();
    } catch (e) {
      debugPrint('Ошибка инициализации Supabase: $e');
      rethrow;
    }
  }

  // Проверка доступности сервера
  static Future<void> _checkServerAvailability() async {
    try {
      debugPrint('Проверка доступности сервера...');

      // Пробуем выполнить простой запрос к базе данных
      final response = await client.from('profiles').select('count').limit(1);
      debugPrint('Сервер доступен, запрос выполнен');
    } catch (e) {
      debugPrint('Сервер недоступен: $e');
      // Не выбрасываем ошибку, так как это может быть нормально
    }
  }
}
