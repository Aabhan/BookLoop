// To parse this JSON data, do
//
//     final donation = donationFromJson(jsonString);

import 'dart:convert';

List<Donation> donationFromJson(String str) =>
    List<Donation>.from(json.decode(str).map((x) => Donation.fromJson(x)));

String donationToJson(List<Donation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Donation {
  String? donateId;
  String? title;
  String? description;
  String? imageUrl;
  String? userId;
  String? fullName;
  String? email;
  String? phoneNumber;

  Donation({
    this.donateId,
    this.title,
    this.description,
    this.imageUrl,
    this.userId,
    this.fullName,
    this.email,
    this.phoneNumber,
  });

  factory Donation.fromJson(Map<String, dynamic> json) => Donation(
        donateId: json["donate_id"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["image_url"],
        userId: json["user_id"],
        fullName: json["full_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "donate_id": donateId,
        "title": title,
        "description": description,
        "image_url": imageUrl,
        "user_id": userId,
        "full_name": fullName,
        "email": email,
        "phone_number": phoneNumber,
      };
}
