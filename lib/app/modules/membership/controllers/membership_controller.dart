import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:get/get.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MembershipController extends GetxController {
  //TODO: Implement MembershipController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void makeMembershipPayment({
    required String amount,
    required String otherData,
  }) async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/makeMembershipPayment');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'amount': amount,
        'other_data': otherData,
      });
      print(response.body);
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
    }
  }

  void increment() => count.value++;
}
