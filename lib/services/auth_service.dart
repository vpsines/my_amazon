import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_amazon/constants/app_constants.dart';
import 'package:my_amazon/helpers/error_handler.dart';
import 'package:my_amazon/helpers/utils.dart';
import 'package:my_amazon/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:my_amazon/providers/user_provider.dart';
import 'package:my_amazon/widgets/base/bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // signup user
  void signUp(
      {required BuildContext context,
      required String email,
      required String name,
      required String password}) async {
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
  void signIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
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
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  void getUserData({required context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
          Uri.parse(AppConstants.baseUrl + AppConstants.validateToken),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);

      if (response) {
        // get user data
        var userResponse = await http.get(
            Uri.parse(AppConstants.baseUrl + AppConstants.getUser),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
