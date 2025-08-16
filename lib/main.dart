import 'package:flutter/material.dart';
import 'package:fort_monitor/presentation/router/app_router.dart';
import 'package:fort_monitor/presentation/theme/app_fonts.dart';

void main() {
  runApp(FortMonitorApp());
}

class FortMonitorApp extends StatelessWidget {
  FortMonitorApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
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
      routerConfig: _appRouter.config(),
    );
  }
}
