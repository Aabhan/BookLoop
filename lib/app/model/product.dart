// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  final String? productId;
  final String? title;
  final String? description;
  final String? categoryId;
  final String? imageUrl;
  final String? isAvailable;
  final String? price;
  final String? categoryTitle;
  final String? isOld;
  final String? isNegotiable;
  final String? userId;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? rating;
  final String? userLocation;

  Product(
      {this.productId,
      this.title,
      this.description,
      this.categoryId,
      this.imageUrl,
      this.isAvailable,
      this.price,
      this.categoryTitle,
      this.isNegotiable,
      this.isOld,
      this.userId,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.rating,
      this.userLocation});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        title: json["title"],
        description: json["description"],
        categoryId: json["category_id"],
        imageUrl: json["image_url"],
        isAvailable: json["is_available"],
        price: json["price"],
        categoryTitle: json["category_title"],
        isNegotiable: json["is_negotiable"],
        isOld: json["is_old"],
        userId: json["user_id"],
        fullName: json["full_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        rating: json["rating"],
        userLocation: json["user_location"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "title": title,
        "description": description,
        "category_id": categoryId,
        "image_url": imageUrl,
        "is_available": isAvailable,
        "price": price,
        "category_title": categoryTitle,
        "is_old": isOld,
        "is_negotiable": isNegotiable,
        "user_id": userId,
        "full_name": fullName,
        "email": email,
        "phone_number": phoneNumber,
        "rating": rating,
        "user_location": userLocation,
      };
}
