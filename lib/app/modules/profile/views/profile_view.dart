import 'package:ecom_2/app/components/logout_button.dart';
import 'package:ecom_2/app/model/user.dart';
import 'package:ecom_2/app/modules/cart/views/cart_view.dart';

import 'package:ecom_2/app/modules/membership/views/membership_view.dart';
import 'package:ecom_2/app/modules/order/views/order_view.dart';
import 'package:ecom_2/app/modules/user_product_list/views/user_product_list_view.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:ecom_2/app/views/views/about_us_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: const Color(0xff9CC69B),
      ),
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: const Color(0xff9CC69B),
                      child: Text(
                        (controller.user?.fullName?[0].toUpperCase() ?? '') +
                            (controller.user?.fullName?[1].toUpperCase() ?? ''),
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.user?.fullName?.toUpperCase() ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.email,
                              color: Color(0xff9CC69B),
                              size: 20,
                            ),
                            const SizedBox(
                                width:
                                    5), // Adjust the spacing between icon and text
                            Text(
                              controller.user?.email ?? '',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              color: Color(0xff9CC69B),
                              size: 20,
                            ),
                            const SizedBox(
                                width:
                                    5), // Adjust the spacing between icon and text
                            Text(
                              controller.user?.phoneNumber ?? '',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Color(0xff9CC69B),
                              size: 20,
                            ),
                            const SizedBox(
                                width:
                                    5), // Adjust the spacing between icon and text
                            Text(
                              controller.user?.userLocation ?? '',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  height: 50,
                  color: Colors.grey,
                ),
                const SizedBox(height: 3),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 217, 240, 216),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text('Edit Profile'),
                        trailing:
                            const Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () {
                          Get.toNamed(Routes.EDIT_PROFILE, arguments: User);
                        },
                      ),
                      ListTile(
                        title: const Text('My Favourites'),
                        trailing:
                            const Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartView(),
                              ));
                        },
                      ),
                      ListTile(
                        title: const Text('My Products'),
                        trailing:
                            const Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () {
                          Get.toNamed(Routes.USER_PRODUCT_LIST);
                        },
                      ),
                      ListTile(
                        title: const Text('My Order Details'),
                        trailing:
                            const Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () {
                          Get.toNamed(Routes.USER_ORDER_DETAILS);
                        },
                      ),
                      ListTile(
                        title: const Text('Membership Plan'),
                        trailing:
                            const Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MembershipView(),
                              ));
                        },
                      ),
                      ListTile(
                        title: const Text('About Us'),
                        trailing:
                            const Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutUsView(),
                              ));
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                LogOutButton(
                  tittle: 'Log Out',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: const Text(
                          'Are you sure you want to logout?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              MemoryManagement.removeAll();
                              Get.offAllNamed(Routes.LOGIN);
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
