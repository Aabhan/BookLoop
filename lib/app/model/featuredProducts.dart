// To parse this JSON data, do
//
//     final featuredProducts = featuredProductsFromJson(jsonString);

import 'dart:convert';

List<FeaturedProducts> featuredProductsFromJson(String str) =>
    List<FeaturedProducts>.from(
        json.decode(str).map((x) => FeaturedProducts.fromJson(x)));

String featuredProductsToJson(List<FeaturedProducts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeaturedProducts {
  String? productId;
  String? title;
  String? description;
  String? categoryId;
  String? imageUrl;
  String? isAvailable;
  String? price;
  String? rating;
  String? isOld;
  String? isNegotiable;
  String? userId;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? userLocation;

  FeaturedProducts({
    this.productId,
    this.title,
    this.description,
    this.categoryId,
    this.imageUrl,
    this.isAvailable,
    this.price,
    this.rating,
    this.isOld,
    this.isNegotiable,
    this.userId,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.userLocation,
  });

  factory FeaturedProducts.fromJson(Map<String, dynamic> json) =>
      FeaturedProducts(
        productId: json["product_id"],
        title: json["title"],
        description: json["description"],
        categoryId: json["category_id"],
        imageUrl: json["image_url"],
        isAvailable: json["is_available"],
        price: json["price"],
        rating: json["rating"],
        isOld: json["is_old"],
        isNegotiable: json["is_negotiable"],
        userId: json["user_id"],
        fullName: json["full_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
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
        "rating": rating,
        "is_old": isOld,
        "is_negotiable": isNegotiable,
        "user_id": userId,
        "full_name": fullName,
        "email": email,
        "phone_number": phoneNumber,
        "user_location": userLocation,
      };
}
