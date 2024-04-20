import 'dart:convert';
import 'dart:typed_data';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/donation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminDonationsController extends GetxController {
  RxList<Donation>? donation = <Donation>[].obs;
  var isLoading = false.obs;
  XFile? donationImage;
  Uint8List? imageBytes;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getDonatedBook();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getDonatedBook() async {
    try {
      isLoading(true);
      var url = Uri.http(ipAddress, 'ecom2_api/getDonation');
      var response = await http.get(url);

      var result = jsonDecode(response.body);

      if (result['success']) {
        donation!.value = donationFromJson(jsonEncode(result['data']));
      } else {
        Get.snackbar(
          'Success',
          result['message'],
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load blogs',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading(false);
    }
  }

  callnumber(Donation donation) async {
    if (donation.phoneNumber != null) {
      // Check if user and phone number are available
      String phoneNumber =
          donation.phoneNumber!; // Accessing user's phone number
      String url = 'tel:$phoneNumber'; // Creating tel URL
      await launch(url); // Launching phone app with the provided phone number
    } else {
      // Handle case where user or phone number is not available
      // You can show a snackbar or toast to inform the user
      Get.snackbar('Error', 'Phone Number not available !',
          duration: Duration(seconds: 3), snackPosition: SnackPosition.TOP);
    }
  }

  void increment() => count.value++;
}
