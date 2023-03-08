import 'package:flutter/material.dart';
import 'package:my_amazon/constants/app_colors.dart';
import 'package:my_amazon/models/order.dart';
import 'package:my_amazon/screens/account/order_detail_screen.dart';
import 'package:my_amazon/services/account_service.dart';
import 'package:my_amazon/widgets/account/product_item.dart';
import 'package:my_amazon/widgets/base/loader.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final AccountService accountService = AccountService();
  List<Order>? orders;

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  Future<void> getOrders() async {
    orders = await accountService.getOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (orders == null)
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      'See all',
                      style: TextStyle(color: AppColors.selectedNavBarColor),
                    ),
                  ),
                  // display orders
                  Container(
                    height: 170,
                    padding: const EdgeInsets.only(left: 10, right: 0, top: 20),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: orders!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, OrderDetailsScreen.routeName,arguments: orders![index]);
                            },
                            child: ProductItem(
                              imageUrl: orders![index].products[0].images[0],
                            ),
                          );
                        }),
                  )
                ],
              )
            ],
          );
  }
}
