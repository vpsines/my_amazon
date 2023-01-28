import 'package:flutter/material.dart';
import 'package:my_amazon/screens/auth/auth_screen.dart';

Route<dynamic> generateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    default:
      return MaterialPageRoute(
        settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("Page not found!"),
                ),
              ));
  }
}
