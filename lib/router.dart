import 'package:flutter/material.dart';
import 'package:my_amazon/screens/auth/auth_screen.dart';
import 'package:my_amazon/screens/home/home_screen.dart';

Route<dynamic> generateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(settings:routeSettings,builder: (_)=>const HomeScreen());
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
