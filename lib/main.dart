import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fort_monitor/presentation/router/app_router.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';
import 'package:fort_monitor/domain/service/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Инициализация Supabase
    await SupabaseService.initialize();
  } catch (e) {
    debugPrint('Ошибка инициализации Supabase: $e');
    // Продолжаем запуск приложения даже при ошибке Supabase
  }

  runApp(const ProviderScope(child: FortMonitorApp()));
}

class FortMonitorApp extends ConsumerWidget {
  const FortMonitorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = AppRouter();

    return MaterialApp.router(
      title: 'Fort Monitor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Jost',
        textTheme: TextTheme(
          displayLarge: AppFonts.heading1,
          displayMedium: AppFonts.heading2,
          displaySmall: AppFonts.heading3,
          bodyLarge: AppFonts.bodyLarge,
          bodyMedium: AppFonts.bodyMedium,
          bodySmall: AppFonts.bodySmall,
          labelLarge: AppFonts.button,
          labelMedium: AppFonts.bodyMedium,
          labelSmall: AppFonts.caption,
        ),
      ),
      routerConfig: appRouter.config(),
    );
  }
}
