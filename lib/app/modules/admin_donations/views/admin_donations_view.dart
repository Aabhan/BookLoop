import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/blog.dart';
import 'package:ecom_2/app/model/donation.dart';
import 'package:ecom_2/app/modules/admin_donations/controllers/admin_donations_controller.dart';
import 'package:ecom_2/app/modules/home/views/home_view.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/views/views/post_blog_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AdminDonationsView extends GetView<AdminDonationsController> {
  const AdminDonationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminDonationsController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Donated Books'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.donation == null) {
          return const Center(
            child: Text('No blogs available'),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                    height:
                        16), // Add some spacing between the button and the blog list
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.donation!.length,
                    itemBuilder: (context, index) {
                      return AdminDonationCard(
                          donation: controller.donation![index]);
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

class AdminDonationCard extends StatelessWidget {
  final Donation donation;

  const AdminDonationCard({Key? key, required this.donation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminDonationsController());
    return Container(
      height: 120, // Increased container height to accommodate content
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2), // Adjusted shadow offset
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align content at the top
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(8), // Rounded corners for image
                child: Image.network(
                  getImageUrl(donation.imageUrl),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Spread children vertically
                  children: [
                    Text(
                      donation.title ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      maxLines: 2, // Limit title to two lines
                      overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                    ),
                    Text(
                      donation.fullName ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 2, // Limit to two lines
                      overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                    ),
                    Text(
                      donation.email ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 2, // Limit to two lines
                      overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                    ),
                    Text(
                      donation.phoneNumber ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 2, // Limit to two lines
                      overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 20,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.call, color: Colors.green),
              onPressed: () {
                controller.callnumber(donation);
              },
            ),
          ),
        ],
      ),
    );
  }
}
