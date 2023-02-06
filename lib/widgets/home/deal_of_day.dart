import 'package:flutter/material.dart';
import 'package:my_amazon/models/product.dart';
import 'package:my_amazon/screens/product/product_detatils_screen.dart';
import 'package:my_amazon/services/home_service.dart';
import 'package:my_amazon/widgets/base/loader.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final HomeService homeService = HomeService();
  Product? product;

  @override
  void initState() {
    super.initState();
    getDealOfTheDay();
  }

  Future<void> getDealOfTheDay() async {
    product = await homeService.getDealOfTheDay(context: context);
    setState(() {});
  }

  void navigateToDetailsScreen(){
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return (product == null)
        ? const Loader()
        : (product!.name.isEmpty)
            ? const SizedBox()
            : GestureDetector(
              onTap: navigateToDetailsScreen,
              child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                      'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: const Text(
                        '\$100',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: const Text(
                        'Apple Mac Book',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map((e) => Image.network(
                                  e,
                                  fit: BoxFit.fitWidth,
                                  width: 100,
                                  height: 100,
                                ))
                            .toList(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(vertical: 15)
                          .copyWith(left: 15),
                      child: Text(
                        'See all deals',
                        style: TextStyle(color: Colors.cyan[800]),
                      ),
                    )
                  ],
                ),
            );
  }
}
