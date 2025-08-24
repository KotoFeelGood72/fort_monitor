import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fort_monitor/presentation/screens/pages.dart';
import 'package:fort_monitor/presentation/router/auth_router.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route,Screen')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // Главный роутер с проверкой авторизации
    AutoRoute(path: '/', page: AuthRouterRoute.page, initial: true),

    // Экраны авторизации
    AutoRoute(path: '/login', page: LoginScreenRoute.page),
    AutoRoute(path: '/register', page: RegisterScreenRoute.page),
    AutoRoute(path: '/password-change', page: PasswordChangeScreenRoute.page),

    // Главные экраны
    AutoRoute(path: '/main', page: MainScreenRoute.page),
    AutoRoute(path: '/care', page: MainCareScreenRoute.page),
    AutoRoute(path: '/parts', page: MainPartsScreenRoute.page),
    AutoRoute(path: '/repair', page: MainRepairScreenRoute.page),
    AutoRoute(path: '/reports', page: MainReportsScreenRoute.page),
    AutoRoute(path: '/routine', page: MainRoutineScreenRoute.page),
    AutoRoute(path: '/stations', page: MainStationsScreenRoute.page),
    AutoRoute(path: '/tires', page: MainTiresScreenRoute.page),
    AutoRoute(path: '/developer', page: MainDeveloperScreenRoute.page),
    AutoRoute(path: '/developer/:id', page: SingleDeveloperScreenRoute.page),
    AutoRoute(path: '/profile', page: MainProfileScreenRoute.page),
    AutoRoute(path: '/profile/:id', page: SingleProfileScreenRoute.page),
  ];
}
