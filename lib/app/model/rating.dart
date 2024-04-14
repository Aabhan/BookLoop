// To parse this JSON data, do
//
//     final rating = ratingFromJson(jsonString);

import 'dart:convert';

List<Rating> ratingFromJson(String str) =>
    List<Rating>.from(json.decode(str).map((x) => Rating.fromJson(x)));

String ratingToJson(List<Rating> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rating {
  String? ratingId;
  String? rating;
  String? reviews;
  String? userId;
  String? productId;
  String? fullName;
  String? email;
  String? phoneNumber;

  Rating({
    this.ratingId,
    this.rating,
    this.reviews,
    this.userId,
    this.productId,
    this.fullName,
    this.email,
    this.phoneNumber,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        ratingId: json["rating_id"],
        rating: json["rating"],
        reviews: json["reviews"],
        userId: json["user_id"],
        productId: json["product_id"],
        fullName: json["full_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "rating_id": ratingId,
        "rating": rating,
        "reviews": reviews,
        "user_id": userId,
        "product_id": productId,
        "full_name": fullName,
        "email": email,
        "phone_number": phoneNumber,
      };
}
