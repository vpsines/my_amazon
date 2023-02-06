import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:my_amazon/constants/app_constants.dart';
import 'package:my_amazon/helpers/error_handler.dart';
import 'package:my_amazon/helpers/utils.dart';
import 'package:my_amazon/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:my_amazon/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeService {
  // to get products of a category
  Future<List<Product>> getCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> products = [];

    try {
      http.Response res = await http.get(
          Uri.parse(
              '${AppConstants.baseUrl}${AppConstants.getCategoryProducts}?category=$category'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body); i++) {
              products.add(Product.fromJson(jsonDecode(res.body)[i]));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return products;
  }

  // to get deal of the day
  Future<Product> getDealOfTheDay({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
        name: '',
        description: '',
        quantity: 0,
        images: [],
        category: '',
        price: 0);

    try {
      http.Response res = await http.get(
          Uri.parse('${AppConstants.baseUrl}${AppConstants.dealOfDay}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            product = Product.fromJson(jsonDecode(res.body));
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
