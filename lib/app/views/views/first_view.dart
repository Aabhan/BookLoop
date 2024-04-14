import 'package:ecom_2/app/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstView extends GetView {
  const FirstView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<OnboardingController>();
    return Scaffold(
      body: Stack(
        children: [
          // Background image starting from the top
          Positioned.fill(
            bottom: 400.0, // Aligning image to the top
            child: Image.asset(
              'assets/BookLoopLogo.png',
            ),
          ),

          Positioned(
            bottom: 400.0,
            left: 20.0,
            right: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Book Loop',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: controller.nextPage,
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 40.0,
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
