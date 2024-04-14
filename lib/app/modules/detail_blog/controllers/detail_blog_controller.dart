import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/blog.dart';
import 'package:ecom_2/app/model/user.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailBlogController extends GetxController {
  Blog? blog;
  User? user;
  var isLoading = true.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // getBlog();
    getuser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getBlog() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getBlogInfo');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
      });
      var result = jsonDecode(response.body);

      if (result['success']) {
        blog = Blog.fromJson(result['data']);

        isLoading.value = false; // Update loading state
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
      isLoading.value = false; // Update loading state in case of error
    }
  }

  void getuser() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getUserInfo');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
      });
      var result = jsonDecode(response.body);

      if (result['success']) {
        user = User.fromJson(result['data']);
        isLoading.value = false; // Update loading state
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
      isLoading.value = false; // Update loading state in case of error
    }
  }

  void increment() => count.value++;
}
