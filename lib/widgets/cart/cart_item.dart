import 'package:flutter/material.dart';
import 'package:my_amazon/models/product.dart';
import 'package:my_amazon/providers/user_provider.dart';
import 'package:my_amazon/screens/product/product_detatils_screen.dart';
import 'package:my_amazon/services/cart_service.dart';
import 'package:my_amazon/services/product_details_service.dart';
import 'package:my_amazon/widgets/base/custom_rating_widget.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final int index;
  const CartItem({super.key, required this.index});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

  final ProductDetailsService productDetailsService = ProductDetailsService();
  final CartService cartService = CartService();

  void increaseQuantity(Product product){
    productDetailsService.addToCart(context: context, product: product);
  }

    void decreaseQuantity(Product product){
    cartService.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final cartProduct = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromJson(cartProduct['product']);
    final quantity = Product.fromJson(cartProduct['quantity']);

    double totalRating = 0;
    double avgRating = 0;

    for (int i = 0; i < product.ratings!.length; i++) {
      totalRating += product.ratings![i].rating;
    }

    if (totalRating != 0) {
      avgRating = totalRating / product.ratings!.length;
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.routeName,
            arguments: product);
      },
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Image.network(
                    product.images[0],
                    fit: BoxFit.fitWidth,
                    height: 135,
                    width: 135,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          product.name,
                          style: const TextStyle(fontSize: 16),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: CustomRatingWidget(
                          rating: avgRating,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: const Text(
                          'Eligible for free shipping',
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          '\$${product.price}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: const Text(
                          'In Stock',
                          style: TextStyle(fontSize: 16, color: Colors.teal),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  )
                ],
              )),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1.5),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black12),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => decreaseQuantity(product),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.remove,
                            size: 18,
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black12, width: 1.5),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0)),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Text(
                            '$quantity',
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => increaseQuantity(product),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.add,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
