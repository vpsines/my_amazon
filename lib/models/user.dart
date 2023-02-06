import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String token;
  final String address;
  final String type;
  final List<dynamic> cart;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.token,
      required this.type,
      required this.cart,
      this.address = ''});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        id: map['_id'] ?? '',
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        token: map['token'] ?? '',
        type: map['userType'] ?? '',
        cart: List<Map<String, dynamic>>.from(
            map["cart"]?.map((x) => Map<String, dynamic>.from(x))));
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "name": name,
      "email": email,
      "password": password,
      "userType": type,
      "token": token,
      "cart": cart
    };
  }

  String toJson() => jsonEncode(toMap());

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? token,
    String? address,
    String? type,
    List<dynamic>? cart,
  }) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        token: token ?? this.token,
        type: type ?? this.type,
        cart: cart ?? this.cart);
  }
}
