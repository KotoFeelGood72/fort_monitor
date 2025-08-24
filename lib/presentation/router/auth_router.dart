import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fort_monitor/presentation/riverpod/supabase_auth_notifier.dart';
import 'package:fort_monitor/presentation/screens/auth/auth_screen.dart';
import 'package:fort_monitor/presentation/screens/main/main_screen.dart';

@RoutePage()
class AuthRouter extends ConsumerWidget {
  const AuthRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(supabaseAuthNotifierProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          // Пользователь авторизован - показываем главный экран
          return const MainScreen();
        } else {
          // Пользователь не авторизован - показываем экран авторизации
          return const AuthScreen();
        }
      },
      loading: () {
        // Показываем загрузку
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
      error: (error, stack) {
        // Показываем экран авторизации при ошибке
        return const AuthScreen();
      },
    );
  }
}
