// To parse this JSON data, do
//
//     final orderDetails = orderDetailsFromJson(jsonString);

import 'dart:convert';

List<OrderDetails> orderDetailsFromJson(String str) => List<OrderDetails>.from(
    json.decode(str).map((x) => OrderDetails.fromJson(x)));

String orderDetailsToJson(List<OrderDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderDetails {
  String? orderDetailId;
  String? orderId;
  String? productId;
  String? quantity;
  String? lineTotal;
  String? userId;
  DateTime? orderDate;
  String? status;
  String? title;
  String? price;
  String? imageUrl;

  OrderDetails({
    this.orderDetailId,
    this.orderId,
    this.productId,
    this.quantity,
    this.lineTotal,
    this.userId,
    this.orderDate,
    this.status,
    this.title,
    this.price,
    this.imageUrl,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        orderDetailId: json["order_detail_id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        lineTotal: json["line_total"],
        userId: json["user_id"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        status: json["status"],
        title: json["title"],
        price: json["price"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "order_detail_id": orderDetailId,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "line_total": lineTotal,
        "user_id": userId,
        "order_date":
            "${orderDate!.year.toString().padLeft(4, '0')}-${orderDate!.month.toString().padLeft(2, '0')}-${orderDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "title": title,
        "price": price,
        "image_url": imageUrl,
      };
}
