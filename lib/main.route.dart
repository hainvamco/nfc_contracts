import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_contracts/main.dart';
import 'package:nfc_contracts/presenter/home/home.page.dart';
import 'package:nfc_contracts/presenter/register/register.page.dart';
import 'package:nfc_contracts/presenter/splash/splash.page.dart';
import 'package:rxdart/subjects.dart';

/// The route configuration.
final GoRouter routerMain = GoRouter(
  observers: [MyNavigatorObserver()],
  navigatorKey: navigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: RouterPath.routerHome,
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
        ),
        GoRoute(
          path: RouterPath.routerRegister,
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterPage();
          },
        ),
      ],
    ),
  ],
);

class RouterPath {
  static const String routerHome = '/home';
  static const String routerRegister = '/register';
}

class MyNavigatorObserver extends NavigatorObserver {
  static var listRoute = <String>[];
  static final BehaviorSubject<String> currentRouter =
      BehaviorSubject<String>();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    listRoute.add(route.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('didPush route ${listRoute.join(',')}');
  }

  String? get lastRoute {
    if (listRoute.isNotEmpty) {
      return listRoute.last;
    }
    return null;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    listRoute.remove(route.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('---current_route_path: ${listRoute.join(',')}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    listRoute.remove(route.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('didRemove route ${listRoute.join(',')}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    listRoute.remove(oldRoute?.settings.name ?? '');
    listRoute.add(newRoute?.settings.name ?? '');
    if (listRoute.isNotEmpty) {
      currentRouter.add(listRoute.last);
    }
    print('didReplace route ${listRoute.join(',')}');
  }
}

extension RouterMain on BuildContext {
  void popUntilPath({required String routePath}) {
    final router = GoRouter.of(this);

    while (router.routerDelegate.currentConfiguration.last.route.path !=
        routePath) {
      if (!router.canPop()) {
        return;
      }

      debugPrint(
          '---popUntilPath from: ${router.routerDelegate.currentConfiguration.last.route.path}');
      router.pop();
    }
  }
}
