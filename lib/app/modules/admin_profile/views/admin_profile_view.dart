import 'package:ecom_2/app/components/admin_logout_button.dart';
import 'package:ecom_2/app/components/logout_button.dart';
import 'package:ecom_2/app/modules/membership/views/membership_view.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:ecom_2/app/views/views/about_us_view.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_profile_controller.dart';

class AdminProfileView extends GetView<AdminProfileController> {
  const AdminProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: GetBuilder<AdminProfileController>(
        init: AdminProfileController(),
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
                      backgroundColor: Colors.teal,
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
                        Text(
                          controller.user?.email ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          controller.user?.phoneNumber ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          controller.user?.role?.toUpperCase() ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(
                  height: 50,
                  color: Colors.grey,
                ),
                // const SizedBox(height: 10),
                // Container(
                //   padding: const EdgeInsets.all(20.0),
                //   decoration: BoxDecoration(
                //     color: Colors.indigo,
                //     borderRadius: BorderRadius.circular(10.0),
                //   ),
                //   child: Column(
                //     children: [
                //       ListTile(
                //         title: const Text(
                //           'Edit Profile',
                //           style: TextStyle(color: Colors.white),
                //         ),
                //         trailing: const Icon(
                //           Icons.keyboard_arrow_right_rounded,
                //           color: Colors.white,
                //         ),
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) =>
                //                       const EditProfileView()));
                //         },
                //       ),
                //       ListTile(
                //         title: const Text(
                //           'My Favourites',
                //           style: TextStyle(color: Colors.white),
                //         ),
                //         trailing: const Icon(
                //           Icons.keyboard_arrow_right_rounded,
                //           color: Colors.white,
                //         ),
                //         onTap: () {
                //           // Navigator.push(
                //           //     context,
                //           //     MaterialPageRoute(
                //           //       builder: (context) => const CartView(),
                //           //     ));
                //         },
                //       ),
                //       ListTile(
                //         title: const Text(
                //           'Membership Plan',
                //           style: TextStyle(color: Colors.white),
                //         ),
                //         trailing: const Icon(Icons.keyboard_arrow_right_rounded,
                //             color: Colors.white),
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => const MembershipView(),
                //               ));
                //         },
                //       ),
                //       ListTile(
                //         title: const Text(
                //           'About Us',
                //           style: TextStyle(color: Colors.white),
                //         ),
                //         trailing: const Icon(Icons.keyboard_arrow_right_rounded,
                //             color: Colors.white),
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => const AboutUsView(),
                //               ));
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 30),
                Center(
                  child: AdminLogOutButton(
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
