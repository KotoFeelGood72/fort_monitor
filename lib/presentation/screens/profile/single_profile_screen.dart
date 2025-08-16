import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SingleProfileScreen extends StatelessWidget {
  const SingleProfileScreen({super.key, @PathParam('id') required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Профиль - $id')),
      body: Center(child: Text('Детали настройки для ID: $id')),
    );
  }
}
