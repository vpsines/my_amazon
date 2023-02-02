import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_amazon/constants/images.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: Images.carouselImages.map((i) {
        return Builder(
            builder: (context) => Image.network(
                  i,
                  fit: BoxFit.cover,
                  height: 200,
                ));
      }).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200
      ),
    );
  }
}
