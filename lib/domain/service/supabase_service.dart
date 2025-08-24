import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static const String _supabaseUrl = 'https://difqshdstbudtgiwyjhn.supabase.co';
  static const String _supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRpZnFzaGRzdGJ1ZHRnaXd5amhuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTU4NjMyMTAsImV4cCI6MjA3MTQzOTIxMH0.VyqTult5rQEWTJrzpKjS1QkugstBVlQO2LuNU9OtrZw';

  static SupabaseClient get client => Supabase.instance.client;

  // Инициализация Supabase
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: _supabaseUrl,
      anonKey: _supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
    );
  }
}
