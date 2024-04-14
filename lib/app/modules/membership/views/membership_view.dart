import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../controllers/membership_controller.dart';

class MembershipView extends GetView<MembershipController> {
  const MembershipView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MembershipController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Membership Plan'),
        centerTitle: true,
        backgroundColor: const Color(0xff9CC69B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'BookLoop Membership Plan',
                style: TextStyle(
                  color: Color(0xff9CC69B),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Rs. 300/ Month',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                child: Image(
                    height: 250,
                    image: AssetImage(
                      'assets/BookLoopLogo.png',
                    )),
              ),
              const SizedBox(height: 30),
              const Text(
                'Membership Benefits:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              _buildBenefit('Early Access To Features'),
              _buildBenefit('Top Search Results'),
              _buildBenefit('Priority Customer Support'),
              _buildBenefit('Easy Sharing'),
              _buildBenefit('Increased Visibility'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    KhaltiScope.of(Get.context!).pay(
                      preferences: [
                        PaymentPreference.khalti,
                        PaymentPreference.connectIPS
                      ],
                      config: PaymentConfig(
                        amount: 19999, // Assuming the membership fee is fixed
                        productIdentity:
                            'membership', // Unique identifier for membership
                        productName: "Membership",
                      ),
                      onSuccess: (PaymentSuccessModel v) {
                        // Handle payment success
                        controller.makeMembershipPayment(
                          amount: (v.amount / 100)
                              .toString(), // Convert amount to string
                          otherData: v.toString(), // Additional data if needed
                        );
                      },
                      onFailure: (v) {
                        // Handle payment failure
                        Get.showSnackbar(const GetSnackBar(
                          backgroundColor: Colors.red,
                          message: 'Payment failed!',
                          duration: Duration(seconds: 3),
                        ));
                      },
                      onCancel: () {
                        // Handle payment cancellation
                        Get.showSnackbar(const GetSnackBar(
                          backgroundColor: Colors.red,
                          message: 'Payment cancelled!',
                          duration: Duration(seconds: 3),
                        ));
                      },
                    );
                  } catch (e) {
                    // Handle any other errors
                    print('Error making membership payment: $e');
                    Get.showSnackbar(const GetSnackBar(
                      backgroundColor: Colors.red,
                      message: 'Something went wrong',
                      duration: Duration(seconds: 3),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff9CC69B), // Button color
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0,
                  ),
                  child: Text(
                    'Get Membership',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefit(String text) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle,
          color: Color(0xff9CC69B),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
