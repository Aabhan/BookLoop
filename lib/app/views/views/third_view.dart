import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThirdView extends GetView {
  const ThirdView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThirdView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ThirdView is working',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.LOGIN);
                // Handle button press, navigate to another screen, etc.
              },
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
