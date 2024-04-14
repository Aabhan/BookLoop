import 'package:get/get.dart';

import '../controllers/user_product_edit_controller.dart';

class UserProductEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProductEditController>(
      () => UserProductEditController(),
    );
  }
}
