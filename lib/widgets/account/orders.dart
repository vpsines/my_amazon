import 'package:flutter/material.dart';
import 'package:my_amazon/constants/app_colors.dart';
import 'package:my_amazon/widgets/account/product_item.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const ProductItem(imageUrl: 'https://images.unsplash.com/photo-1661961112951-f2bfd1f253ce?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1172&q=80',);
                  }),
            )
          ],
        )
      ],
    );
  }
}