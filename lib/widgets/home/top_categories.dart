import 'package:flutter/material.dart';
import 'package:my_amazon/constants/images.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Images.categoryImages.length,
        itemExtent:75,
        itemBuilder: (context,index){
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(Images.categoryImages[index]['image']!,fit: BoxFit.cover,height: 40,),
                ),
              ),
              Text(Images.categoryImages[index]['title']!,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12
              ),
              )
            ],
          );
        }),
    );
  }
}