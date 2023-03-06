import 'package:flutter/material.dart';
import 'package:my_amazon/models/order.dart';
import 'package:my_amazon/models/product.dart';
import 'package:my_amazon/screens/account/order_detail_screen.dart';
import 'package:my_amazon/screens/address/address_screen.dart';
import 'package:my_amazon/screens/admin/add_product_screen.dart';
import 'package:my_amazon/screens/auth/auth_screen.dart';
import 'package:my_amazon/screens/cart/cart_screen.dart';
import 'package:my_amazon/screens/home/category_deals_screen.dart';
import 'package:my_amazon/screens/home/home_screen.dart';
import 'package:my_amazon/screens/product/product_detatils_screen.dart';
import 'package:my_amazon/screens/search/search_screen.dart';
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
    case SearchScreen.routeName:
      var query = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
                query: query,
              ));
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(
                product: product,
              ));
    case CartScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const CartScreen());
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;

      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddressScreen(
                totalAmount: totalAmount,
              ));
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;

      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailsScreen(
                order: order,
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
