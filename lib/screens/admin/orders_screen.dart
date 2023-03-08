import 'package:flutter/material.dart';
import 'package:my_amazon/models/order.dart';
import 'package:my_amazon/screens/account/order_detail_screen.dart';
import 'package:my_amazon/services/admin_service.dart';
import 'package:my_amazon/widgets/account/product_item.dart';
import 'package:my_amazon/widgets/base/loader.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = '/orders-screen';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminService adminService = AdminService();

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  Future<void> getOrders() async {
    orders = await adminService.getAllOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (orders == null)
          ? const Loader()
          : GridView.builder(
              itemCount: orders!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final order = orders![index];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, OrderDetailsScreen.routeName,arguments: order),
                  child: SizedBox(
                    height: 140,
                    child: ProductItem(
                      imageUrl: order.products[0].images[0],
                    ),
                  ),
                );
              }),
    );
  }
}
