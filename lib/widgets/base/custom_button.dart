import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final Color? color;
  const CustomButton(
      {super.key, required this.onTap, required this.buttonText, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50), backgroundColor: color),
      child: Text(
        buttonText,
        style: TextStyle(color: color ?? Colors.white),
      ),
    );
  }
}
