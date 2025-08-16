import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SingleDeveloperScreen extends StatelessWidget {
  const SingleDeveloperScreen({super.key, @PathParam('id') required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Разработчик - $id')),
      body: Center(child: Text('Детали инструмента для ID: $id')),
    );
  }
}
