import 'package:flutter/material.dart';
import 'package:my_amazon/configs/themes/ui_parameters.dart';
import 'package:my_amazon/constants/app_colors.dart';
import 'package:my_amazon/widgets/account/welcome_user_title.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: UiParameters.appBarGradient)
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Image.asset("assets/images/amazon_in.png",
                      width: 120,
                      height: 45,
                      color: Colors.black,),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Row(
                        children:const [
                          Padding(padding: EdgeInsets.only(left: 15),
                          child: Icon(Icons.notifications_outlined),
                          ),
                          Icon(Icons.search),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            body: Column(
              children: const [
                WelcomeUserTitle(),
                SizedBox(height: 10,),
                
              ],
            ),
      );
  }
}