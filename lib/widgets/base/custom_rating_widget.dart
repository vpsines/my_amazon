import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_amazon/constants/app_colors.dart';

class CustomRatingWidget extends StatelessWidget {
  final double rating;

  const CustomRatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      direction: Axis.horizontal,
      itemCount: 5,
      itemSize: 15,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: AppColors.secondaryColor,
      ),
    );
  }
}
