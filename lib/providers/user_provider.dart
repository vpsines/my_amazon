import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:my_amazon/models/user.dart';

class UserProvider extends ChangeNotifier{
  User _user = User(id: "", name: "", email: "", password: "", token: "", type: "");

  User get user => _user;

  void setUser(String user){
    _user = User.fromJson(jsonDecode(user));
    notifyListeners();
  }
}