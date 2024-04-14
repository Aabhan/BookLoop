import 'package:ecom_2/app/components/admin_product_card.dart';
import 'package:ecom_2/app/components/product_card.dart';
import 'package:ecom_2/app/components/user_product_card.dart';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/admin_products/controllers/admin_products_controller.dart';

import 'package:ecom_2/app/modules/cart/views/cart_view.dart';
import 'package:ecom_2/app/modules/user_product_edit/views/user_product_edit_view.dart';
import 'package:ecom_2/app/modules/user_product_list/controllers/user_product_list_controller.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UserProductListView extends GetView<UserProductListController> {
  @override
  UserProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Products'),
          backgroundColor: const Color(0xff9CC69B),
          centerTitle: true,
        ),
        body: GetBuilder<UserProductListController>(builder: (controller) {
          if (controller.userProducts.isEmpty) {
            return Center(child: Text("No products found"));
          } else {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: controller.userProducts.length,
                itemBuilder: (context, index) {
                  var product = controller.userProducts[index];
                  return UserProductListCard(
                      product: product); // Your custom product card widget
                },
              ),
            );
          }
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff9CC69B),
          onPressed: controller.onUserAdd,
          child: const Icon(Icons.add),
        ));
  }
}

class UserProductListCard extends StatelessWidget {
  final Product product;

  const UserProductListCard({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff9CC69B).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(getImageUrl(product.imageUrl)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              // Wrapping Column with SizedBox
              height: 80, // Limiting the height of the Column
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.title ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Condition: ${product.isOld == '1' ? 'Old' : 'New'}',
                        style: const TextStyle(
                          fontSize: 12, // Adjust font size as needed
                        ),
                      ),
                      Text(
                        'Negotiability: ${product.isNegotiable == '1' ? 'Negotiable' : 'Fixed'}',
                        style: const TextStyle(
                          fontSize: 12, // Adjust font size as needed
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.USER_PRODUCT_EDIT, arguments: product);
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => DeleteProductDialog(
                            productId: product.productId ?? '',
                          ));
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
