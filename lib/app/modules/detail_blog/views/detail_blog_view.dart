import 'dart:ffi';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/blog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_blog_controller.dart';

class DetailBlogView extends GetView<DetailBlogController> {
  const DetailBlogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var blog = Get.arguments as Blog;
    var controller = Get.put(DetailBlogController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
        backgroundColor: const Color(0xff9CC69B),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Center(
                            child: Text(
                              blog.title?.toUpperCase() ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Image.network(
                            width: double.infinity,
                            height: Get.height * 0.4,
                            getImageUrl(blog.imageUrl ?? ''),
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            blog.blogDecscription ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: const Color(0xff9CC69B),
                                  child: Text(
                                    (blog.fullName?[0].toUpperCase() ?? '') +
                                        (blog.fullName?[1].toUpperCase() ?? ''),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Written by:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      blog.fullName?.toUpperCase() ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      blog.email ?? '',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }
      }),
    );
  }
}
