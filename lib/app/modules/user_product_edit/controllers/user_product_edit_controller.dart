import 'dart:convert';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/category.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserProductEditController extends GetxController {
  var isLoading = false.obs;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var isOld = false;
  var isNegotiable = false;

  // Method to update product details
  updateProduct(String productId) async {
    try {
      isLoading(true);

      var url = Uri.http(ipAddress, 'ecom2_api/editProductList');

      var response = await http.post(url, body: {
        'title': titleController.text,
        'token': MemoryManagement.getAccessToken(),
        'description': descriptionController.text,
        'price': priceController.text,
        // 'is_old': isOld.toString(),
        // 'is_negotiable': isNegotiable.toString(),
        'is_old': isOld ? '1' : '0', // Convert boolean to integer
        'is_negotiable': isNegotiable ? '1' : '0',
        'product_id': productId,
      });
      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    } finally {
      isLoading(false);
    }
  }
}
