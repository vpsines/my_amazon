import 'package:flutter/material.dart';
import 'package:my_amazon/constants/app_colors.dart';
import 'package:my_amazon/providers/user_provider.dart';
import 'package:my_amazon/router.dart';
import 'package:my_amazon/screens/auth/auth_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundColor,
          appBarTheme: const AppBarTheme(
              elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
          colorScheme:
              const ColorScheme.light(primary: AppColors.secondaryColor)),
      onGenerateRoute: (settings) => generateRoutes(settings),
      home: const AuthScreen(),
    );
  }
}
