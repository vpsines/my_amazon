import 'dart:convert';

import 'package:my_amazon/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  final List<Rating>? ratings;

  Product(
      {required this.name,
      required this.description,
      required this.quantity,
      required this.images,
      required this.category,
      required this.price,
      this.id,
      this.ratings});

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0,
      price: map['price'].toDouble() ?? 0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      ratings: map['ratings'] != null ? List<Rating>.from(map['ratings']?.map((e)=> Rating.fromMap(e))):null
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "name": name,
      "description": description,
      "images": images,
      "quantity": quantity,
      "price": price,
      "category": category,
    };
  }

  String toJson() => jsonEncode(toMap());
}
