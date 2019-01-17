import 'package:flutter/material.dart';

class Product {
  int goods_id = 0;
  String name;
  String image;
  double rating;
  String price;
  String brand;
  String description;
  int totalReviews;
  List<String> sizes;
  List<String> smallimages;
  List<String> bigimages;
  List<ProductColor> colors;
  List specNames;
  List specValueNames1;
  List specValueNames2;
  List specValueNames3;
  int quantity = 0;

  

  Product(
      {
      this.goods_id,
      this.name,
      this.image,
      this.smallimages,
      this.bigimages,
      this.brand,
      this.price,
      this.rating,
      this.description,
      this.totalReviews,
      this.sizes,
      this.colors,
      this.specNames,
      this.specValueNames1,
      this.specValueNames2,
      this.specValueNames3,
      this.quantity});

  
}

class ProductColor {
  final String colorName;
  final MaterialColor color;

  ProductColor({this.colorName, this.color});
}


