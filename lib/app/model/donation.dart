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

  Donation({
    this.donateId,
    this.title,
    this.description,
    this.imageUrl,
    this.userId,
  });

  factory Donation.fromJson(Map<String, dynamic> json) => Donation(
        donateId: json["donate_id"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["image_url"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "donate_id": donateId,
        "title": title,
        "description": description,
        "image_url": imageUrl,
        "user_id": userId,
      };
}
