// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../ui/screens/dashboard_screen.dart' as _i5;
import '../../ui/screens/login_screen.dart' as _i4;
import '../../ui/screens/order_summary.dart' as _i6;
import '../../ui/screens/splash_screen.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.SplashScreen();
        }),
    LoginScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i4.LoginScreen();
        }),
    DashBoardScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i5.DashBoardScreen();
        }),
    OrderSummaryRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i6.OrderSummary();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i1.RouteConfig(LoginScreenRoute.name, path: '/login-screen'),
        _i1.RouteConfig(DashBoardScreenRoute.name, path: '/dash-board-screen'),
        _i1.RouteConfig(OrderSummaryRoute.name, path: '/order-summary')
      ];
}

class SplashScreenRoute extends _i1.PageRouteInfo {
  const SplashScreenRoute() : super(name, path: '/');

  static const String name = 'SplashScreenRoute';
}

class LoginScreenRoute extends _i1.PageRouteInfo {
  const LoginScreenRoute() : super(name, path: '/login-screen');

  static const String name = 'LoginScreenRoute';
}

class DashBoardScreenRoute extends _i1.PageRouteInfo {
  const DashBoardScreenRoute() : super(name, path: '/dash-board-screen');

  static const String name = 'DashBoardScreenRoute';
}

class OrderSummaryRoute extends _i1.PageRouteInfo {
  const OrderSummaryRoute() : super(name, path: '/order-summary');

  static const String name = 'OrderSummaryRoute';
}
