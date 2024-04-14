import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecom_2/app/model/userOrder.dart';
import 'package:http/http.dart' as http;

class UserOrderDetailsController extends GetxController {
  var isLoading = false.obs;
  late List<OrderDetails> orderDetails = []; // Initialize as empty list

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getOrderDetails();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getOrderDetails() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getOrderDetails');
      // await Future.delayed(const Duration(seconds: 3));

      var response = await http
          .post(url, body: {'token': MemoryManagement.getAccessToken()});

      var result = jsonDecode(response.body);

      if (result['success']) {
        print(result['data']);
        orderDetails = orderDetailsFromJson(jsonEncode(result['data']));
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  void increment() => count.value++;
}
