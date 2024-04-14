import 'dart:io';

import 'package:ecom_2/app/modules/admin_products/controllers/admin_products_controller.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductPopup extends StatelessWidget {
  const AddProductPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Dialog(
        insetPadding: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: controller.addProductFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add Product',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: controller.titleController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Product Title',
                      hintText: 'Enter product title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: controller.descriptionController,
                    textInputAction: TextInputAction.next,
                    minLines: 3,
                    maxLines: 5,
                    maxLength: 500,
                    decoration: const InputDecoration(
                      labelText: 'Product Description',
                      hintText: 'Enter product description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: controller.priceController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Product Price',
                      hintText: 'Enter product price',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter product price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<HomeController>(
                      builder: (controller) => controller.categories == null
                          ? const CircularProgressIndicator()
                          : DropdownButtonFormField(
                              menuMaxHeight: 350,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                              hint: const Text('Select Category'),
                              items: controller.categories!
                                  .map((category) => DropdownMenuItem(
                                        value: category.categoryId,
                                        child:
                                            Text(category.categoryTitle ?? ''),
                                      ))
                                  .toList(),
                              onChanged: (v) {
                                controller.selectedCategory = v;
                              })),
                  const SizedBox(
                    height: 16,
                  ),
                  DropdownButtonFormField<bool>(
                    decoration: const InputDecoration(
                      labelText: 'Condition',
                      hintText: 'Select Condition of Book',
                      border: OutlineInputBorder(),
                    ),
                    value: null, // No default selection initially
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
                      controller.isOld.value = value ?? false;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropdownButtonFormField<bool>(
                    decoration: const InputDecoration(
                      labelText: 'Price Negotiablity',
                      hintText: 'Select Negotiable',
                      border: OutlineInputBorder(),
                    ),
                    value: null, // No default selection initially
                    items: const [
                      DropdownMenuItem<bool>(
                        value: true,
                        child: Text('Fixed'),
                      ),
                      DropdownMenuItem<bool>(
                        value: false,
                        child: Text('Negotiability'),
                      ),
                    ],
                    onChanged: (value) {
                      controller.isNegotiable.value = value ?? false;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  controller.productImage == null ||
                          controller.imageBytes == null
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal),
                          onPressed: controller.onPickImage,
                          child: const Text('Upload Image'))
                      : Image.memory(controller.imageBytes!),
                  const SizedBox(
                    height: 16,
                  ),
                  AddAdminProductButton(
                      tittle: 'Add Product', onPressed: controller.addProduct)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddAdminProductButton extends StatelessWidget {
  final String tittle;
  final void Function()? onPressed;
  const AddAdminProductButton(
      {super.key, required this.tittle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.teal, borderRadius: BorderRadius.circular(10)),
          height: 50,
          width: Get.width,
          child: Center(
              child: Text(
            tittle,
            style: const TextStyle(color: Colors.white),
          )),
        ));
  }
}
