import 'package:flutter/material.dart';
import 'package:my_amazon/models/product.dart';
import 'package:my_amazon/screens/product/product_detatils_screen.dart';
import 'package:my_amazon/widgets/base/custom_rating_widget.dart';

class SearchProductItem extends StatelessWidget {
  final Product product;

  const SearchProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
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
                        child:  CustomRatingWidget(
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
              ))
        ],
      ),
    );
  }
}
