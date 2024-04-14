import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_donations_controller.dart';

class AdminDonationsView extends GetView<AdminDonationsController> {
  const AdminDonationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminDonationsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminDonationsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
