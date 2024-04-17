import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/user.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  User? user;
  var fullNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();

  var isLoading = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchUserProfile() async {
    try {
      // Send updated details to API
      var url = Uri.http(ipAddress, 'ecom2_api/getUserInfo');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
      });
      var result = jsonDecode(response.body);
      print(result);
      if (result['success']) {
        user = User.fromJson(result['data']);
        fullNameController.text = user!.fullName!;
        phoneNumberController.text = user!.phoneNumber!;

        emailController.text = user!.email!;
      } else {
        Get.snackbar('Error', result['message'],
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3));
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred');
    }
  }

  updateProfile() async {
    try {
      isLoading(true);

      var url = Uri.http(ipAddress, 'ecom2_api/updateProfile');

      var response = await http.post(url, body: {
        'full_name': fullNameController.text,
        'token': MemoryManagement.getAccessToken(),
        'phone_number': phoneNumberController.text,
        'email': emailController.text,
      });
      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.back();
        Get.snackbar(
          'Profile Updated',
          result['message'],
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          'Error',
          result['message'],
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something Went Wrong',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void increment() => count.value++;
}
