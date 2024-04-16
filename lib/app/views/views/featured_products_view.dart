import 'package:ecom_2/app/components/product_card.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeaturedProductsView extends GetView {
  final List<Product>? products;

  const FeaturedProductsView({Key? key, required this.products})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Featured Products'),
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
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                controller.featuredProducts == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        // Set the scrolling direction
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of items per row
                          mainAxisSpacing: 16, // Spacing between rows
                          crossAxisSpacing: 16, // Spacing between columns
                        ),
                        itemCount: controller.featuredProducts?.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),

                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: controller.featuredProducts![index],
                          );
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
