import 'dart:convert';
import 'dart:typed_data';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/blog.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class BlogController extends GetxController {
  // var isLoading = false.obs;
  // List<Blog>? blogs;
  var addBlogFormKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  XFile? blogImage;
  Uint8List? imageBytes;

  RxList<Blog>? blogs = <Blog>[].obs; // Use RxList for reactive list

  var isLoading = false.obs; // Reactive loading indicator

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getBlog();
  }

  void onPickImage() async {
    try {
      blogImage = await picker.pickImage(source: ImageSource.gallery);
      imageBytes = await blogImage!.readAsBytes();
      update();
    } catch (e) {}
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void getBlog() async {
  //   try {
  //     var url = Uri.http(ipAddress, 'ecom2_api/getBlog');
  //     var response = await http.get(url);

  //     var result = jsonDecode(response.body);

  //     if (result['success']) {
  //       blogs = blogFromJson(jsonEncode(result['data']));
  //       Get.showSnackbar(const GetSnackBar(
  //         backgroundColor: Colors.blue,
  //         message: 'Something went wrong',
  //         duration: Duration(seconds: 3),
  //       ));

  //       update();
  //     }
  //   } catch (e) {
  //     Get.showSnackbar(const GetSnackBar(
  //       backgroundColor: Colors.red,
  //       message: 'Something went wrong',
  //       duration: Duration(seconds: 3),
  //     ));
  //   }
  // }
  void getBlog() async {
    try {
      isLoading(true);
      var url = Uri.http(ipAddress, 'ecom2_api/getBlog');
      var response = await http.get(url);

      var result = jsonDecode(response.body);

      if (result['success']) {
        blogs!.value = blogFromJson(jsonEncode(result['data']));
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Something went wrong',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load blogs',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  void addBlog() async {
    try {
      if (addBlogFormKey.currentState!.validate()) {
        try {
          var url = Uri.http(ipAddress, 'ecom2_api/addBlog');

          var request = http.MultipartRequest('POST', url);

          request.fields['title'] = titleController.text;
          request.fields['blog_description'] = descriptionController.text;
          request.fields['token'] = MemoryManagement.getAccessToken()!;
          // request.files.add(
          //   http.MultipartFile.fromBytes(
          //     'image',
          //     imageBytes!,
          //     filename: blogImage!.name,
          //   ),
          // );
          // Check if an image is selected
          if (blogImage != null && imageBytes != null) {
            request.files.add(
              http.MultipartFile.fromBytes(
                'image',
                imageBytes!,
                filename: blogImage!.name,
              ),
            );
          }

          titleController.clear();
          descriptionController.clear();
          // Clear image picker selection
          blogImage = null;
          imageBytes = null;

          // request.fields['blog_date'] = dateController.text;

          var responseData = await request.send();

          var response = await http.Response.fromStream(responseData);

          var result = jsonDecode(response.body);

          if (result['success']) {
            Get.back();
            getBlog();
            Get.snackbar(
              'Blog Added',
              'Thank you for adding your blog',
              snackPosition: SnackPosition.TOP,
            );
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
    } catch (e) {}
  }

  void increment() => count.value++;
}
