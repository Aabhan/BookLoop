// To parse this JSON data, do
//
//     final stats = statsFromJson(jsonString);

import 'dart:convert';

Stats statsFromJson(String str) => Stats.fromJson(json.decode(str));

String statsToJson(Stats data) => json.encode(data.toJson());

class Stats {
  final String? totalIncome;
  final String? totalUsers;
  final String? totalOrders;
  final String? totalProducts;
  final String? totalBlog;
  final String? totalDonation;

  Stats({
    this.totalIncome,
    this.totalUsers,
    this.totalOrders,
    this.totalProducts,
    this.totalBlog,
    this.totalDonation,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        totalIncome: json["total_income"],
        totalUsers: json["total_users"],
        totalOrders: json["total_orders"],
        totalProducts: json["total_products"],
        totalBlog: json["total_blog"],
        totalDonation: json["total_donation"],
      );

  Map<String, dynamic> toJson() => {
        "total_income": totalIncome,
        "total_users": totalUsers,
        "total_orders": totalOrders,
        "total_products": totalProducts,
        "total_blog": totalBlog,
        "total_donation": totalDonation,
      };
}
