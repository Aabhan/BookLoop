import 'package:get/get.dart';

import '../controllers/user_product_list_controller.dart';

class UserProductListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProductListController>(
      () => UserProductListController(),
    );
  }
}
