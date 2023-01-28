import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final VoidCallback onTap;
  final String buttonText;
  
  const CustomButton({super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50)
      ),
      child: Text(buttonText),
    );
  }
}