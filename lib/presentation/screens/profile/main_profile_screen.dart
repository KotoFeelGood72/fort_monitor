import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class MainProfileScreen extends StatelessWidget {
  const MainProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Настройка ${index + 1}'),
            subtitle: Text('Описание настройки ${index + 1}'),
            onTap: () {
              // TODO: Добавить навигацию к детальному экрану
            },
          );
        },
      ),
    );
  }
}
