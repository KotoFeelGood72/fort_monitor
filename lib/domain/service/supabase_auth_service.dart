import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupabaseAuthService {
  static SupabaseClient get client => Supabase.instance.client;

  // Получение текущего пользователя
  static User? get currentUser => client.auth.currentUser;

  // Проверка авторизации
  static bool get isAuthenticated => currentUser != null;

  // Поток изменений состояния авторизации
  static Stream<AuthState> get authStateChanges =>
      client.auth.onAuthStateChange;

  // Регистрация пользователя
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? userData,
  }) async {
    return await client.auth.signUp(
      email: email,
      password: password,
      data: userData,
    );
  }

  // Вход пользователя
  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Выход пользователя
  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  // Сброс пароля
  static Future<void> resetPassword(String email) async {
    await client.auth.resetPasswordForEmail(email);
  }

  // Обновление пароля
  static Future<UserResponse> updatePassword(String newPassword) async {
    return await client.auth.updateUser(UserAttributes(password: newPassword));
  }

  // Получение профиля пользователя
  static Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      final response = await client
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();
      return response;
    } catch (e) {
      return null;
    }
  }

  // Обновление профиля пользователя
  static Future<void> updateUserProfile({
    required String userId,
    required Map<String, dynamic> profileData,
  }) async {
    await client.from('profiles').update(profileData).eq('id', userId);
  }

  // Обновление метаданных пользователя
  static Future<UserResponse> updateUserMetadata(
    Map<String, dynamic> metadata,
  ) async {
    return await client.auth.updateUser(UserAttributes(data: metadata));
  }

  // Создание профиля пользователя
  static Future<void> createUserProfile({
    required String userId,
    required Map<String, dynamic> profileData,
  }) async {
    await client.from('profiles').insert({'id': userId, ...profileData});
  }

  // Удаление профиля пользователя
  static Future<void> deleteUserProfile(String userId) async {
    await client.from('profiles').delete().eq('id', userId);
  }

  // Удаление аккаунта пользователя
  static Future<void> deleteAccount() async {
    await client.auth.admin.deleteUser(client.auth.currentUser!.id);
  }
}

// Провайдер для SupabaseAuthService
final supabaseAuthServiceProvider = Provider<SupabaseAuthService>((ref) {
  return SupabaseAuthService();
});

// Провайдер для текущего пользователя
final currentUserProvider = StreamProvider<User?>((ref) {
  return SupabaseAuthService.authStateChanges.map(
    (event) => event.session?.user,
  );
});

// Провайдер для состояния авторизации
final isAuthenticatedProvider = Provider<bool>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  return userAsync.when(
    data: (user) => user != null,
    loading: () => false,
    error: (_, __) => false,
  );
});
