import 'package:get/get.dart';

import '../controllers/detail_blog_controller.dart';

class DetailBlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailBlogController>(
      () => DetailBlogController(),
    );
  }
}
