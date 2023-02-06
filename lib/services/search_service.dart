import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_amazon/constants/app_constants.dart';
import 'package:my_amazon/helpers/error_handler.dart';
import 'package:my_amazon/helpers/utils.dart';
import 'package:my_amazon/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:my_amazon/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SearchService {
  // to search  products
  Future<List<Product>> searchProducts(
      {required BuildContext context, required String searchQuery}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> products = [];

    try {
      http.Response res = await http.get(
          Uri.parse(
              '${AppConstants.baseUrl}${AppConstants.searchProducts}/$searchQuery'),
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
}
