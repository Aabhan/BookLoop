import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesView extends GetView {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
        backgroundColor: const Color(0xff9CC69B),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          if (controller.categories == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(35.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                mainAxisSpacing: 20.0, // Spacing between items vertically
                crossAxisSpacing: 20.0, // Spacing between items horizontally
              ),
              itemCount: controller.categories?.length ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.DETAIL_CATEGORY,
                        arguments: controller.categories?[index]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.categories?[index].categoryTitle ?? '',
                          style: const TextStyle(
                            color: Color(0xff9CC69B),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
