import 'package:flutter/material.dart';
import 'package:my_amazon/screens/admin/add_product_screen.dart';
import 'package:my_amazon/screens/auth/auth_screen.dart';
import 'package:my_amazon/screens/home/category_deals_screen.dart';
import 'package:my_amazon/screens/home/home_screen.dart';
import 'package:my_amazon/widgets/base/bottom_bar.dart';

Route<dynamic> generateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDealsScreen(
                category: category,
              ));
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
