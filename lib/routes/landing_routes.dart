import 'package:flutter/material.dart';
import 'package:password_manager/home/home_screen.dart';
import 'package:password_manager/login/login_screen.dart';
import 'package:password_manager/routes/landing_routes_constants.dart';

class LandingRoutes {
  static Route<dynamic> generateRouteLanding(final RouteSettings settings) {
    switch (settings.name) {
      case rootRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
