import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/donate_controller.dart';

class DonateView extends GetView<DonateController> {
  const DonateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DonateController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate Book'),
        backgroundColor: const Color(0xff9CC69B),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'assets/BookLoopLogo.png',
              height: 150,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Welcome to BookLoop Donate! Help us spread the joy of reading by donating your books. Your donations can make a difference in someone\'s life. Let\'s create a community of book lovers!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.onDonateBook();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff9CC69B),
                textStyle: const TextStyle(fontSize: 18),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Donate Now'),
            ),
          ],
        ),
      ),
    );
  }
}
