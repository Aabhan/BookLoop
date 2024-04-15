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
        backgroundColor: const Color(0xff9CC69B),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.titleController,
                      decoration: const InputDecoration(
                        border:
                            OutlineInputBorder(), // Add border to the dropdown field
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 12.0),
                        labelText: 'Title',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border:
                            OutlineInputBorder(), // Add border to the dropdown field
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 60.0),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.priceController,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        border:
                            OutlineInputBorder(), // Add border to the dropdown field
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 12.0),
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<bool>(
                      value: controller.isOld,
                      items: const [
                        DropdownMenuItem<bool>(
                          value: true,
                          child: Text(
                            'Old',
                            style: TextStyle(
                              color:
                                  Colors.black, // Adjust text color as needed
                            ),
                          ),
                        ),
                        DropdownMenuItem<bool>(
                          value: false,
                          child: Text(
                            'New',
                            style: TextStyle(
                              color:
                                  Colors.black, // Adjust text color as needed
                            ),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        controller.isOld = value ?? false;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Condition',
                        hintText: 'Select Condition',
                        border:
                            OutlineInputBorder(), // Add border to the dropdown field
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 12.0), // Adjust padding as needed
                        // You can add other InputDecoration properties as desired
                      ),
                      style: const TextStyle(
                          color: Colors
                              .black), // Adjust dropdown button text color
                      icon: const Icon(
                          Icons.arrow_drop_down), // Add custom dropdown icon
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<bool>(
                      value: controller.isNegotiable,
                      items: const [
                        DropdownMenuItem<bool>(
                          value: true,
                          child: Text('Negotiable'),
                        ),
                        DropdownMenuItem<bool>(
                          value: false,
                          child: Text('Fix'),
                        ),
                      ],
                      onChanged: (value) {
                        controller.isNegotiable = value ?? false;
                      },
                      decoration: const InputDecoration(
                        border:
                            OutlineInputBorder(), // Add border to the dropdown field
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 12.0),
                        labelText: 'Price Negotiability',
                        hintText: 'Select Negotiability',
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff9CC69B),
                      ),
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
