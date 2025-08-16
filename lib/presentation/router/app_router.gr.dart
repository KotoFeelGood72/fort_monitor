// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [MainCareScreen]
class MainCareScreenRoute extends PageRouteInfo<void> {
  const MainCareScreenRoute({List<PageRouteInfo>? children})
    : super(MainCareScreenRoute.name, initialChildren: children);

  static const String name = 'MainCareScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainCareScreen();
    },
  );
}

/// generated route for
/// [MainDeveloperScreen]
class MainDeveloperScreenRoute extends PageRouteInfo<void> {
  const MainDeveloperScreenRoute({List<PageRouteInfo>? children})
    : super(MainDeveloperScreenRoute.name, initialChildren: children);

  static const String name = 'MainDeveloperScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainDeveloperScreen();
    },
  );
}

/// generated route for
/// [MainPartsScreen]
class MainPartsScreenRoute extends PageRouteInfo<void> {
  const MainPartsScreenRoute({List<PageRouteInfo>? children})
    : super(MainPartsScreenRoute.name, initialChildren: children);

  static const String name = 'MainPartsScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainPartsScreen();
    },
  );
}

/// generated route for
/// [MainProfileScreen]
class MainProfileScreenRoute extends PageRouteInfo<void> {
  const MainProfileScreenRoute({List<PageRouteInfo>? children})
    : super(MainProfileScreenRoute.name, initialChildren: children);

  static const String name = 'MainProfileScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainProfileScreen();
    },
  );
}

/// generated route for
/// [MainRepairScreen]
class MainRepairScreenRoute extends PageRouteInfo<void> {
  const MainRepairScreenRoute({List<PageRouteInfo>? children})
    : super(MainRepairScreenRoute.name, initialChildren: children);

  static const String name = 'MainRepairScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainRepairScreen();
    },
  );
}

/// generated route for
/// [MainReportsScreen]
class MainReportsScreenRoute extends PageRouteInfo<void> {
  const MainReportsScreenRoute({List<PageRouteInfo>? children})
    : super(MainReportsScreenRoute.name, initialChildren: children);

  static const String name = 'MainReportsScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainReportsScreen();
    },
  );
}

/// generated route for
/// [MainRoutineScreen]
class MainRoutineScreenRoute extends PageRouteInfo<void> {
  const MainRoutineScreenRoute({List<PageRouteInfo>? children})
    : super(MainRoutineScreenRoute.name, initialChildren: children);

  static const String name = 'MainRoutineScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainRoutineScreen();
    },
  );
}

/// generated route for
/// [MainScreen]
class MainScreenRoute extends PageRouteInfo<void> {
  const MainScreenRoute({List<PageRouteInfo>? children})
    : super(MainScreenRoute.name, initialChildren: children);

  static const String name = 'MainScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainScreen();
    },
  );
}

/// generated route for
/// [MainStationsScreen]
class MainStationsScreenRoute extends PageRouteInfo<void> {
  const MainStationsScreenRoute({List<PageRouteInfo>? children})
    : super(MainStationsScreenRoute.name, initialChildren: children);

  static const String name = 'MainStationsScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainStationsScreen();
    },
  );
}

/// generated route for
/// [MainTiresScreen]
class MainTiresScreenRoute extends PageRouteInfo<void> {
  const MainTiresScreenRoute({List<PageRouteInfo>? children})
    : super(MainTiresScreenRoute.name, initialChildren: children);

  static const String name = 'MainTiresScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainTiresScreen();
    },
  );
}

/// generated route for
/// [SingleDeveloperScreen]
class SingleDeveloperScreenRoute
    extends PageRouteInfo<SingleDeveloperScreenRouteArgs> {
  SingleDeveloperScreenRoute({
    Key? key,
    required String id,
    List<PageRouteInfo>? children,
  }) : super(
         SingleDeveloperScreenRoute.name,
         args: SingleDeveloperScreenRouteArgs(key: key, id: id),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'SingleDeveloperScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SingleDeveloperScreenRouteArgs>(
        orElse: () =>
            SingleDeveloperScreenRouteArgs(id: pathParams.getString('id')),
      );
      return SingleDeveloperScreen(key: args.key, id: args.id);
    },
  );
}

class SingleDeveloperScreenRouteArgs {
  const SingleDeveloperScreenRouteArgs({this.key, required this.id});

  final Key? key;

  final String id;

  @override
  String toString() {
    return 'SingleDeveloperScreenRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SingleDeveloperScreenRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [SingleProfileScreen]
class SingleProfileScreenRoute
    extends PageRouteInfo<SingleProfileScreenRouteArgs> {
  SingleProfileScreenRoute({
    Key? key,
    required String id,
    List<PageRouteInfo>? children,
  }) : super(
         SingleProfileScreenRoute.name,
         args: SingleProfileScreenRouteArgs(key: key, id: id),
         rawPathParams: {'id': id},
         initialChildren: children,
       );

  static const String name = 'SingleProfileScreenRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<SingleProfileScreenRouteArgs>(
        orElse: () =>
            SingleProfileScreenRouteArgs(id: pathParams.getString('id')),
      );
      return SingleProfileScreen(key: args.key, id: args.id);
    },
  );
}

class SingleProfileScreenRouteArgs {
  const SingleProfileScreenRouteArgs({this.key, required this.id});

  final Key? key;

  final String id;

  @override
  String toString() {
    return 'SingleProfileScreenRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SingleProfileScreenRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}
