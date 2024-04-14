import 'dart:convert';
import 'dart:typed_data';

import 'package:ecom_2/app/components/donate_book_popup.dart';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/donation.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class DonateController extends GetxController {
  List<Donation>? donations;

  var addDonationFormKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  XFile? donateImage;
  Uint8List? imageBytes;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getDonatedBooks();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addDonateBook() async {
    try {
      if (addDonationFormKey.currentState!.validate()) {
        try {
          var url = Uri.http(ipAddress, 'ecom2_api/addDonation');

          var request = http.MultipartRequest('POST', url);

          request.fields['title'] = titleController.text;
          titleController.clear();
          request.fields['description'] = descriptionController.text;
          descriptionController.clear();

          request.fields['token'] = MemoryManagement.getAccessToken()!;

          if (donateImage != null && imageBytes != null) {
            request.files.add(
              http.MultipartFile.fromBytes(
                'image',
                imageBytes!,
                filename: donateImage!.name,
              ),
            );
          }
          donateImage = null;
          imageBytes = null;

          var responseData = await request.send();
          var response = await http.Response.fromStream(responseData);
          var result = jsonDecode(response.body);

          if (result['success']) {
            Get.back();
            getDonatedBooks();
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
          Get.showSnackbar(const GetSnackBar(
            backgroundColor: Colors.red,
            message: 'Something went wrong',
            duration: Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {}
  }

  void getDonatedBooks() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getDonation');
      var response = await http.get(url);

      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));

        donations = donationFromJson(
          jsonEncode(result['data']),
        );
        update();
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  void onDonateBook() {
    showDialog(
        context: Get.context!, builder: (context) => const DonateBookPopup());
  }

  void onPickImage() async {
    try {
      donateImage = await picker.pickImage(source: ImageSource.gallery);
      imageBytes = await donateImage!.readAsBytes();
      update();
    } catch (e) {}
  }

  void increment() => count.value++;
}
