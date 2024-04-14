import 'dart:convert';

import 'package:ecom_2/app/components/addUserProductPopUp.dart';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserProductListController extends GetxController {
  var userProducts = <Product>[].obs; // List to store user's products

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserProducts();
  }

  @override
  void onReady() {
    super.onReady();
    // fetchUserProducts();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Method to fetch user's products (replace with your own logic)
  fetchUserProducts() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getUserProductList');

      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        print(result['products']);
        List<dynamic> fetchedProducts = result['products'];
        var products = fetchedProducts.map((e) => Product.fromJson(e)).toList();
        userProducts.assignAll(products);

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

  void onUserAdd() {
    showDialog(
        context: Get.context!,
        builder: (context) => const AddUserProductPopup());
  }

  // Method to add a new product
  void addProduct(Product product) {
    // Example: Add the new product to the user's products list
    userProducts.add(product);
  }
}
