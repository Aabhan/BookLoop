// To parse this JSON data, do
//
//     final blog = blogFromJson(jsonString);

import 'dart:convert';

List<Blog> blogFromJson(String str) =>
    List<Blog>.from(json.decode(str).map((x) => Blog.fromJson(x)));

String blogToJson(List<Blog> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Blog {
  final String? blogId;
  final String? title;
  final String? blogDecscription;
  final DateTime? blogDate;
  final String? userId;
  final String? imageUrl;
  final String? fullName;
  final String? email;

  Blog({
    this.blogId,
    this.title,
    this.blogDecscription,
    this.blogDate,
    this.userId,
    this.imageUrl,
    this.fullName,
    this.email,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        blogId: json["blog_id"],
        title: json["title"],
        blogDecscription: json["blog_decscription"],
        blogDate: json["blog_date"] == null
            ? null
            : DateTime.parse(json["blog_date"]),
        userId: json["user_id"],
        imageUrl: json["image_url"],
        fullName: json["full_name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "blog_id": blogId,
        "title": title,
        "blog_decscription": blogDecscription,
        "blog_date":
            "${blogDate!.year.toString().padLeft(4, '0')}-${blogDate!.month.toString().padLeft(2, '0')}-${blogDate!.day.toString().padLeft(2, '0')}",
        "user_id": userId,
        "image_url": imageUrl,
        "full_name": fullName,
        "email": email,
      };
}
