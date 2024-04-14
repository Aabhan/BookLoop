import 'package:get/get.dart';

import '../controllers/admin_donations_controller.dart';

class AdminDonationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDonationsController>(
      () => AdminDonationsController(),
    );
  }
}
