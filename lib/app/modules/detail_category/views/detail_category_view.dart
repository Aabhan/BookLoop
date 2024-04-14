import 'package:ecom_2/app/components/admin_product_card.dart';
import 'package:ecom_2/app/components/product_card.dart';
import 'package:ecom_2/app/components/user_product_card.dart';
import 'package:ecom_2/app/model/category.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_category_controller.dart';

class DetailCategoryView extends GetView<DetailCategoryController> {
  const DetailCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var category = Get.arguments as Category;
    var controller = Get.put(DetailCategoryController());
    return Scaffold(
        appBar: AppBar(
          title: Text(category.categoryTitle ?? ''),
          // backgroundColor: const Color(0xff9CC69B),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                final product = controller.products[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.DETAILED_PRODUCT,
                        arguments: controller.products?[index]);
                  },
                  child: SizedBox(
                    height: 100,
                    child: UserProductCard(
                      product: product,
                    ),
                  ),
                );
              }),
        ));
  }
}
