# Настройка Supabase для Fort Monitor

## Шаги настройки:

### 1. Создание проекта в Supabase
1. Перейдите на [supabase.com](https://supabase.com)
2. Создайте новый проект
3. Запишите URL и anon key

### 2. Настройка базы данных
1. Откройте SQL Editor в вашем проекте Supabase
2. Выполните SQL скрипт из файла `supabase_setup.sql`

### 3. Настройка аутентификации
1. В разделе Authentication > Settings:
   - Включите Email auth
   - Настройте подтверждение email (опционально)
   - Настройте redirect URLs для вашего приложения

### 4. Обновление конфигурации в коде
В файле `lib/domain/service/supabase_service.dart` обновите:
```dart
static const String _supabaseUrl = 'YOUR_SUPABASE_URL';
static const String _supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
```

### 5. Настройка Row Level Security (RLS)
RLS уже настроен в SQL скрипте, но убедитесь что:
- RLS включен для таблицы `profiles`
- Политики безопасности созданы правильно

### 6. Тестирование
1. Запустите приложение: `flutter run`
2. Попробуйте зарегистрировать нового пользователя
3. Проверьте вход в систему
4. Проверьте сброс пароля

## Структура базы данных

### Таблица `profiles`
- `id` (UUID, Primary Key) - ссылка на auth.users
- `email` (TEXT, Unique) - email пользователя
- `full_name` (TEXT) - полное имя
- `company` (TEXT) - компания
- `position` (TEXT) - должность
- `phone` (TEXT) - телефон
- `created_at` (TIMESTAMP) - дата создания
- `updated_at` (TIMESTAMP) - дата обновления

## Безопасность
- Все таблицы защищены Row Level Security (RLS)
- Пользователи могут читать/обновлять только свои данные
- Автоматическое создание профиля при регистрации
- Безопасное хранение токенов в flutter_secure_storage
