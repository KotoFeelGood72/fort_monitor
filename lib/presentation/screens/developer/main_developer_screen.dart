import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class MainDeveloperScreen extends StatelessWidget {
  const MainDeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Разработчик')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Инструмент ${index + 1}'),
            subtitle: Text('Описание инструмента ${index + 1}'),
            onTap: () {
              // TODO: Добавить навигацию к детальному экрану
            },
          );
        },
      ),
    );
  }
}
