import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_amazon/configs/themes/ui_parameters.dart';
import 'package:my_amazon/constants/app_colors.dart';
import 'package:my_amazon/constants/images.dart';
import 'package:my_amazon/models/product.dart';
import 'package:my_amazon/providers/user_provider.dart';
import 'package:my_amazon/screens/search/search_screen.dart';
import 'package:my_amazon/services/product_details_service.dart';
import 'package:my_amazon/widgets/base/custom_button.dart';
import 'package:my_amazon/widgets/base/custom_rating_widget.dart';
import 'package:my_amazon/widgets/home/carousel_image.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsService productDetailsService = ProductDetailsService();

  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.ratings!.length; i++) {
      totalRating += widget.product.ratings![i].rating;
      if (widget.product.ratings![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.ratings![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.ratings!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart(){
    productDetailsService.addToCart(context: context, product: widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: UiParameters.appBarGradient)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(7),
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1)),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17)),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                color: Colors.transparent,
                height: 42,
                child: const Icon(
                  Icons.mic,
                  size: 25,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [CustomRatingWidget(rating: avgRating)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                widget.product.name,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            CarouselSlider(
              items: widget.product.images.map((i) {
                return Builder(
                    builder: (context) => Image.network(
                          i,
                          fit: BoxFit.contain,
                          height: 200,
                        ));
              }).toList(),
              options: CarouselOptions(viewportFraction: 1, height: 300),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                    text: 'Deal Price: ',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: '\$${widget.product.price}',
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      )
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(onTap: () {}, buttonText: 'Buy Now'),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                onTap: () {
                  addToCart();
                },
                buttonText: 'Add to  Cart',
                color: const Color.fromARGB(254, 216, 19, 1),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Rate the product',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            RatingBar.builder(
                initialRating: myRating,
                minRating: 1,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemBuilder: (context, _) {
                  return const Icon(Icons.star,
                      color: AppColors.secondaryColor);
                },
                onRatingUpdate: (rating) {
                  productDetailsService.rateProduct(
                      context: context,
                      product: widget.product,
                      rating: rating);
                })
          ],
        ),
      ),
    );
  }
}
