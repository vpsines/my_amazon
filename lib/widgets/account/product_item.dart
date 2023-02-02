import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;

  const ProductItem({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 1.5
        ),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(8),
        child: Image.network(imageUrl,fit: BoxFit.fitHeight,width: 180,),
      ),
    );
  }
}