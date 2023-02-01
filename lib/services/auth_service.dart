import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_amazon/constants/app_constants.dart';
import 'package:my_amazon/helpers/error_handler.dart';
import 'package:my_amazon/helpers/utils.dart';
import 'package:my_amazon/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:my_amazon/providers/user_provider.dart';
import 'package:my_amazon/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // signup user
  void signUp(
      {required context,
      required email,
      required name,
      required password}) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          token: '',
          type: '');

      http.Response res = await http.post(
          Uri.parse(AppConstants.baseUrl + AppConstants.signUp),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, "Account created! Login with same credentials.");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // signin user
  void signIn({required context, required email, required password}) async {
    try {
      User user = User(
          id: '',
          name: '',
          email: email,
          password: password,
          token: '',
          type: '');

      http.Response res = await http.post(
          Uri.parse(AppConstants.baseUrl + AppConstants.signIn),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
