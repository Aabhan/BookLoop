import 'dart:convert';
import 'dart:typed_data';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/user.dart';
import 'package:ecom_2/app/modules/profile/controllers/profile_controller.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  final User user = Get.arguments;
  var formKey = GlobalKey<FormState>();

  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fullNameController.text = user.fullName ?? '';
    emailController.text = user.email ?? '';

    // void onImagePick() async {
    //   final ImagePicker picker = ImagePicker();
    //   imageFile = await picker.pickImage(source: ImageSource.gallery);

    //   if (imageFile != null) {
    //     imageBytes = await imageFile!.readAsBytes();
    //     update();
    //   }
    // }
  }

  onUpdateProfile() async {
    try {
      if (formKey.currentState!.validate()) {
        var url = Uri.http(ipAddress, 'ecom2_api/updateProfile.php');
        var response = await http.post(url, body: {
          'token': MemoryManagement.getAccessToken(),
          'full_name': fullNameController.text,
          'phone_number': phoneNumberController.text,
        });
        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.back();
          Get.find<ProfileController>().getuser();
          Get.snackbar(
            'Update Profile',
            result['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Update Profile',
            result['message'],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Update Profile',
        'Something went wrong',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
