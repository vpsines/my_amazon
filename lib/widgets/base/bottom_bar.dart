import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:my_amazon/constants/app_colors.dart';
import 'package:my_amazon/providers/user_provider.dart';
import 'package:my_amazon/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const Center(
      child: Text("Account"),
    ),
    const Center(
      child: Text("Cart"),
    ),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updatePage,
        currentIndex: _page,
        selectedItemColor: AppColors.selectedNavBarColor,
        unselectedItemColor: AppColors.unselectedNavBarColor,
        backgroundColor: AppColors.backgroundColor,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: _page == 0
                      ? AppColors.selectedNavBarColor
                      : AppColors.backgroundColor,
                  width: bottomBarBorderWidth,
                ))),
                child: const Icon(Icons.home_outlined),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: _page == 1
                      ? AppColors.selectedNavBarColor
                      : AppColors.backgroundColor,
                  width: bottomBarBorderWidth,
                ))),
                child: const Icon(Icons.person_outline),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: _page == 2
                      ? AppColors.selectedNavBarColor
                      : AppColors.backgroundColor,
                  width: bottomBarBorderWidth,
                ))),
                child: Badge(
                    badgeStyle: const BadgeStyle(
                        badgeColor: Colors.white, elevation: 0),
                    badgeContent: Text('$userCartLength'),
                    child: const Icon(Icons.shopping_cart_outlined)),
              ),
              label: ''),
        ],
      ),
    );
  }
}
