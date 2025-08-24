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
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Загрузка...'),
              ],
            ),
          ),
        );
      },
      error: (error, stack) {
        // Показываем экран авторизации при ошибке с возможностью повтора
        debugPrint('Ошибка авторизации: $error');

        // Определяем тип ошибки
        String errorTitle = 'Ошибка подключения';
        String errorMessage = 'Проверьте интернет-соединение';

        if (error.toString().contains('Failed host lookup')) {
          errorTitle = 'Проблема с DNS';
          errorMessage =
              'Не удается найти сервер. Возможно, проблема с интернет-соединением или DNS.';
        } else if (error.toString().contains('SocketException')) {
          errorTitle = 'Ошибка сети';
          errorMessage =
              'Проблема с сетевым подключением. Проверьте интернет-соединение.';
        } else if (error.toString().contains('timeout')) {
          errorTitle = 'Таймаут подключения';
          errorMessage = 'Сервер не отвечает. Попробуйте позже.';
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, size: 80, color: Colors.red),
                    const SizedBox(height: 32),
                    Text(
                      errorTitle,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      errorMessage,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          // Перезагружаем состояние авторизации
                          ref.invalidate(supabaseAuthNotifierProvider);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Повторить',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: () {
                          // Переходим к главному экрану без авторизации
                          Navigator.of(context).pushReplacementNamed('/main');
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Продолжить без авторизации',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
