import 'package:ecom_2/app/components/My_button.dart';
import 'package:ecom_2/app/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondView extends GetView {
  const SecondView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<OnboardingController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('SecondView'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/thirdView.jpg',
            ),
          ),
          // Next page arrow
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: GestureDetector(
              onTap: controller.nextPage,
              child: Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 40.0,
              ),
            ),
          ),
          // Back arrow
          Positioned(
            top: 20.0,
            left: 20.0,
            child: GestureDetector(
              onTap: Get.back,
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 40.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
