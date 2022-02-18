import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  String id;
  String title;
  String imageUrl;
  double price;
  bool isFavorite;
  String description;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
    this.description = "",
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
