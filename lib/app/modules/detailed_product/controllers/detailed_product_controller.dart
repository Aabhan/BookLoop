import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/model/user.dart';
import 'package:ecom_2/app/model/rating.dart';
import 'package:ecom_2/app/modules/home/views/home_view.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DetailedProductController extends GetxController {
  RxList<Rating> rating = <Rating>[].obs;
  var product = Get.arguments as Product;

  var isLoading = true.obs; // Track loading state
  var quantity = 1.obs;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // String productId = 'product_id';
    // getProduct(productId);
    getRating(product.productId);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onRatingSubmit(
      {required double rating,
      required String review,
      required String? productId}) async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/giveRating');
      var response = await http.post(url, body: {
        'product_id': productId,
        "rating": rating,
        "reviews": review,
        "token": MemoryManagement.getAccessToken(),
      });
      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 2),
        ));
        // Update loading state
        update(); // Update the view
      } else {
        isLoading.value = false; // Update loading state
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  void getRating(productId) async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getRating');
      var response = await http.post(url, body: {
        'productId': productId,
      });
      var result = jsonDecode(response.body);
      print(result['data']);
      if (result['success']) {
        rating = ratingFromJson(jsonEncode(result['data'])).obs;
        isLoading.value = false;
        // Update loading state
        update(); // Update the view
      } else {
        isLoading.value = false; // Update loading state
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  callnumber(Product product) async {
    if (product.phoneNumber != null) {
      // Check if user and phone number are available
      String phoneNumber =
          product.phoneNumber!; // Accessing user's phone number
      String url = 'tel:$phoneNumber'; // Creating tel URL
      await launch(url); // Launching phone app with the provided phone number
    } else {
      // Handle case where user or phone number is not available
      // You can show a snackbar or toast to inform the user
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Phone number not available',
        duration: Duration(seconds: 3),
      ));
    }
  }

  void increment() => count.value++;
}
