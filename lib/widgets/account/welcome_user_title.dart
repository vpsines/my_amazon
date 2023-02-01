import 'package:flutter/material.dart';
import 'package:my_amazon/configs/themes/ui_parameters.dart';
import 'package:my_amazon/providers/user_provider.dart';
import 'package:provider/provider.dart';

class WelcomeUserTitle extends StatelessWidget {
  const WelcomeUserTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      decoration: const BoxDecoration(
        gradient: UiParameters.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          RichText(
              text: TextSpan(
                  text: 'Hello',
                  style: const TextStyle(color: Colors.black, fontSize: 22),
                  children: [
                TextSpan(
                  text: user.name,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                )
              ])),
        ],
      ),
    );
  }
}
