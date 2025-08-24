import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fort_monitor/domain/service/supabase_auth_service.dart';

// Провайдер для состояния загрузки
final authLoadingProvider = StateProvider<bool>((ref) => false);

// Провайдер для ошибок аутентификации
final authErrorProvider = StateProvider<String?>((ref) => null);

// Auth Notifier для управления авторизацией
class SupabaseAuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final Ref _ref;

  SupabaseAuthNotifier(this._ref) : super(const AsyncValue.loading()) {
    _initializeAuth();
  }

  void _initializeAuth() {
    try {
      final user = SupabaseAuthService.currentUser;
      if (user != null) {
        state = AsyncValue.data(user);
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e) {
      debugPrint('Ошибка инициализации авторизации: $e');
      state = const AsyncValue.data(null);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String company,
    required String position,
    required String phone,
  }) async {
    try {
      _ref.read(authLoadingProvider.notifier).state = true;
      _ref.read(authErrorProvider.notifier).state = null;

      final response = await SupabaseAuthService.signUp(
        email: email,
        password: password,
        userData: {
          'full_name': fullName,
          'company': company,
          'position': position,
          'phone': phone,
        },
      );

      if (response.user != null) {
        // Создаем профиль пользователя
        await SupabaseAuthService.createUserProfile(
          userId: response.user!.id,
          profileData: {
            'full_name': fullName,
            'company': company,
            'position': position,
            'phone': phone,
            'email': email,
          },
        );

        state = AsyncValue.data(response.user);
      } else {
        _ref.read(authErrorProvider.notifier).state = 'Ошибка регистрации';
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      _ref.read(authErrorProvider.notifier).state = e.toString();
    } finally {
      _ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      _ref.read(authLoadingProvider.notifier).state = true;
      _ref.read(authErrorProvider.notifier).state = null;

      final response = await SupabaseAuthService.signIn(
        email: email,
        password: password,
      );

      if (response.user != null) {
        state = AsyncValue.data(response.user);
      } else {
        _ref.read(authErrorProvider.notifier).state =
            'Неверный email или пароль';
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);

      // Улучшенная обработка ошибок
      String errorMessage = 'Ошибка авторизации';

      if (e.toString().contains('Failed host lookup')) {
        errorMessage =
            'Ошибка подключения к серверу. Проверьте интернет-соединение.';
      } else if (e.toString().contains('Invalid login credentials')) {
        errorMessage = 'Неверный email или пароль';
      } else if (e.toString().contains('Email not confirmed')) {
        errorMessage = 'Email не подтвержден. Проверьте почту.';
      } else if (e.toString().contains('Too many requests')) {
        errorMessage = 'Слишком много попыток входа. Попробуйте позже.';
      } else {
        errorMessage = 'Ошибка авторизации: ${e.toString()}';
      }

      _ref.read(authErrorProvider.notifier).state = errorMessage;
    } finally {
      _ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  Future<void> signOut() async {
    try {
      await SupabaseAuthService.signOut();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      _ref.read(authLoadingProvider.notifier).state = true;
      _ref.read(authErrorProvider.notifier).state = null;

      await SupabaseAuthService.resetPassword(email);
    } catch (e) {
      _ref.read(authErrorProvider.notifier).state = e.toString();
    } finally {
      _ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      _ref.read(authLoadingProvider.notifier).state = true;
      _ref.read(authErrorProvider.notifier).state = null;

      await SupabaseAuthService.updatePassword(newPassword);
    } catch (e) {
      _ref.read(authErrorProvider.notifier).state = e.toString();
    } finally {
      _ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  bool get isAuthenticated {
    return state.value != null;
  }

  User? get currentUser {
    return state.value;
  }
}

// Провайдер для SupabaseAuthNotifier
final supabaseAuthNotifierProvider =
    StateNotifierProvider<SupabaseAuthNotifier, AsyncValue<User?>>((ref) {
      return SupabaseAuthNotifier(ref);
    });

// Провайдеры для удобного доступа к состоянию
final isAuthenticatedProvider2 = Provider<bool>((ref) {
  return ref.watch(supabaseAuthNotifierProvider).value != null;
});

final currentUserProvider2 = Provider<User?>((ref) {
  return ref.watch(supabaseAuthNotifierProvider).value;
});
