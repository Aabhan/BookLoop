import 'dart:io';

import 'package:ecom_2/app/components/Donate_button.dart';
import 'package:ecom_2/app/components/My_button.dart';
import 'package:ecom_2/app/modules/admin_products/controllers/admin_products_controller.dart';
import 'package:ecom_2/app/modules/donate/controllers/donate_controller.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonateBookPopup extends StatelessWidget {
  const DonateBookPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DonateController>(
      init: DonateController(),
      builder: (controller) => Dialog(
        insetPadding: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: controller.addDonationFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Donate Book',
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
                      labelText: 'Book Title',
                      hintText: 'Enter Book title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Book title';
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
                      labelText: 'Book Description',
                      hintText: 'Enter Book description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Book description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  controller.donateImage == null ||
                          controller.imageBytes == null
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff9CC69B)),
                          onPressed: controller.onPickImage,
                          child: const Text('Upload Image'))
                      : Image.memory(controller.imageBytes!),
                  const SizedBox(
                    height: 16,
                  ),
                  DonateButton(
                      tittle: 'Donate', onPressed: controller.addDonateBook)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
