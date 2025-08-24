# VehicleStorage - Утилитарный класс для работы с выбранным автомобилем

## Описание

`VehicleStorage` - это утилитарный класс для работы с выбранным транспортным средством через SharedPreferences. Класс предоставляет единый интерфейс для получения и сохранения выбранного автомобиля во всех экранах приложения.

## Основные возможности

- ✅ Автоматическое переключение между SharedPreferences и in-memory хранилищем
- ✅ Обработка ошибок с fallback значениями
- ✅ Единый интерфейс для всех экранов
- ✅ Асинхронная работа с поддержкой Future

## Методы

### `initialize()`
Инициализация SharedPreferences. Должен вызываться при запуске приложения.

```dart
await VehicleStorage.initialize();
```

### `getSelectedVehicle()`
Получить выбранное транспортное средство. Возвращает `String?` (может быть null).

```dart
final vehicle = await VehicleStorage.getSelectedVehicle();
```

### `getSelectedVehicleWithFallback({String fallback = 'ТС'})`
Получить выбранное транспортное средство с fallback значением. Всегда возвращает `String`.

```dart
final vehicle = await VehicleStorage.getSelectedVehicleWithFallback();
// или с кастомным fallback
final vehicle = await VehicleStorage.getSelectedVehicleWithFallback(fallback: 'Автомобиль');
```

### `setSelectedVehicle(String vehicle)`
Сохранить выбранное транспортное средство.

```dart
await VehicleStorage.setSelectedVehicle('ТС C978MK');
```

### `isUsingSharedPreferences`
Проверить, используется ли SharedPreferences (getter).

```dart
if (VehicleStorage.isUsingSharedPreferences) {
  print('Используется SharedPreferences');
} else {
  print('Используется in-memory хранилище');
}
```

## Примеры использования

### В StatefulWidget

```dart
class MyScreen extends StatefulWidget {
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  String? selectedVehicle;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVehicle();
  }

  Future<void> _loadVehicle() async {
    try {
      final vehicle = await VehicleStorage.getSelectedVehicleWithFallback();
      if (mounted) {
        setState(() {
          selectedVehicle = vehicle;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          selectedVehicle = 'ТС';
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }
    
    return Text(selectedVehicle ?? 'ТС');
  }
}
```

### В StatelessWidget с FutureBuilder

```dart
class MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: VehicleStorage.getSelectedVehicleWithFallback(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Загрузка...');
        }
        
        if (snapshot.hasError) {
          return const Text('ТС');
        }
        
        return Text(snapshot.data ?? 'ТС');
      },
    );
  }
}
```

### Простое получение заголовка

```dart
// В любом месте кода
final title = await VehicleStorage.getSelectedVehicleWithFallback();
```

## Миграция с существующего кода

### Было:
```dart
// В каждом экране отдельная логика SharedPreferences
final prefs = await SharedPreferences.getInstance();
final vehicle = prefs.getString('selected_vehicle') ?? 'ТС';
```

### Стало:
```dart
// Единый метод для всех экранов
final vehicle = await VehicleStorage.getSelectedVehicleWithFallback();
```

## Обработка ошибок

Класс автоматически обрабатывает ошибки SharedPreferences и переключается на in-memory хранилище. Все методы возвращают корректные значения даже при ошибках.

## Производительность

- SharedPreferences инициализируется только один раз при запуске приложения
- In-memory хранилище используется как fallback для быстрого доступа
- Все операции асинхронные и не блокируют UI
