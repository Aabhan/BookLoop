import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/featuredProducts.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/cart/controllers/cart_controller.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeaturedProductCard extends StatelessWidget {
  final FeaturedProducts featuredProducts;
  const FeaturedProductCard({super.key, required this.featuredProducts});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();

    // var isFavourtie = false.obs;
    return ClipRRect(
      borderRadius: BorderRadius.circular(5), // Set the border radius here
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.network(
                    getImageUrl(
                      featuredProducts.imageUrl,
                    ),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 140,
                              child: Text(
                                featuredProducts.title?.toUpperCase() ?? '',
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rs${featuredProducts.price ?? ''}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     cartController.addProduct(product: product);
                            //   },
                            //   child: const Icon(Icons.favorite_border),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
