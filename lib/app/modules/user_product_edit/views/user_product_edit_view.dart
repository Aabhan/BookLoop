import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/user_product_edit/controllers/user_product_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProductEditView extends GetView<UserProductEditController> {
  const UserProductEditView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments;
    var controller = Get.put(UserProductEditController());

    // Assign product details to the controller
    controller.titleController.text = product.title ?? '';
    controller.descriptionController.text = product.description ?? '';
    controller.priceController.text = product.price ?? '';

    controller.isOld = product.isOld == "1";
    controller.isNegotiable = product.isNegotiable == "1";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: controller.titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextFormField(
                      controller: controller.descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                    ),
                    TextFormField(
                      controller: controller.priceController,
                      decoration: const InputDecoration(labelText: 'Price'),
                    ),
                    DropdownButtonFormField<bool>(
                      value: controller.isOld,
                      items: [
                        DropdownMenuItem<bool>(
                          value: true,
                          child: const Text('Old'),
                        ),
                        DropdownMenuItem<bool>(
                          value: false,
                          child: const Text('New'),
                        ),
                      ],
                      onChanged: (value) {
                        controller.isOld = value ?? false;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Condition',
                        hintText: 'Select Condition',
                      ),
                    ),
                    DropdownButtonFormField<bool>(
                      value: controller.isNegotiable,
                      items: [
                        DropdownMenuItem<bool>(
                          value: true,
                          child: const Text('Negotiable'),
                        ),
                        DropdownMenuItem<bool>(
                          value: false,
                          child: const Text('Fix'),
                        ),
                      ],
                      onChanged: (value) {
                        controller.isNegotiable = value ?? false;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Price Negotiability',
                        hintText: 'Select Negotiability',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Call the controller method to update the product
                        controller.updateProduct(product.productId.toString());
                      },
                      child: const Text('Update Product'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
