import 'package:ecom_2/app/modules/cart/controllers/cart_controller.dart';
import 'package:ecom_2/app/modules/cart/views/cart_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: const Color(0xff9CC69B),
        centerTitle: true,
      ),
      body: GetBuilder<CartController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Checking Out',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.cart.length,
                  itemBuilder: (context, index) => CartCard(
                    cartItem: controller.cart[index],
                    index: index,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Obx(
                      () => Text(
                        'Rs. ${controller.total.value}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () async {
                        if (controller.cart.isEmpty) {
                          Get.showSnackbar(const GetSnackBar(
                            backgroundColor: Colors.red,
                            message: 'No Products Checkout is empty!',
                            duration: Duration(seconds: 3),
                          ));
                          return;
                        }
                        var orderId = await controller.makeOrder();
                        if (orderId == null) {
                          return;
                        }
                        KhaltiScope.of(Get.context!).pay(
                          preferences: [
                            PaymentPreference.khalti,
                            PaymentPreference.connectIPS
                          ],
                          config: PaymentConfig(
                            amount: 1000,
                            productIdentity: orderId.toString(),
                            productName: "My Product",
                          ),
                          onSuccess: (PaymentSuccessModel v) {
                            controller.makePayment(
                                total: (v.amount / 100).toString(),
                                orderId: orderId.toString(),
                                otherData: v.toString());
                          },
                          onFailure: (v) {
                            Get.showSnackbar(const GetSnackBar(
                              backgroundColor: Colors.red,
                              message: 'Payment failed!',
                              duration: Duration(seconds: 3),
                            ));
                          },
                          onCancel: () {
                            Get.showSnackbar(const GetSnackBar(
                              backgroundColor: Colors.red,
                              message: 'Payment cancelled!',
                              duration: Duration(seconds: 3),
                            ));
                          },
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff9CC69B),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'Pay With Khalti',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
