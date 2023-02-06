import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_amazon/constants/app_constants.dart';
import 'package:my_amazon/helpers/error_handler.dart';
import 'package:my_amazon/helpers/utils.dart';
import 'package:my_amazon/models/product.dart';
import 'package:my_amazon/models/user.dart';
import 'package:my_amazon/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsService {
  /// to rate a product
  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
          Uri.parse(AppConstants.baseUrl + AppConstants.rateProducts),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({'id': product.id, 'rating': rating}));

      httpErrorHandle(response: res, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  /// to add a product to cart
  void addToCart(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
          Uri.parse(AppConstants.baseUrl + AppConstants.addProductToCart),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({'id': product.id}));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
