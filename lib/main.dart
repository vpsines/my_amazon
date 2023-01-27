import 'package:flutter/material.dart';
import 'package:my_amazon/constants/app_colors.dart';

void main() {
  runApp(const MyApp());
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
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black)
        ),
        colorScheme: const ColorScheme.light(
          primary: AppColors.secondaryColor
        )
      ),
      home: Container(),
    );
  }
}