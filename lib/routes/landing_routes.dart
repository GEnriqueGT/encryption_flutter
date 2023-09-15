import 'package:flutter/material.dart';
import 'package:password_manager/home/home_screen.dart';
import 'package:password_manager/login/login_screen.dart';
import 'package:password_manager/password-create/password_create_screen.dart';
import 'package:password_manager/password-preview/password_preview_screen.dart';
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
      case createRoute:
        return MaterialPageRoute(
          builder: (_) => const PasswordCreateScreen(),
        );
      case passwordPreviewRoute:
        final String passwordId = settings.arguments as String ;
        return MaterialPageRoute(
          builder: (_) =>  PasswordPreviewScreen(passwordId: passwordId),
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
