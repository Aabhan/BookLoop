import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/blog.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/views/views/post_blog_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_blogs_controller.dart';

class AdminBlogsView extends GetView<AdminBlogsController> {
  const AdminBlogsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminBlogsController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Blog'),
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
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.blogs == null) {
          return Center(
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
                    itemCount: controller.blogs!.length,
                    itemBuilder: (context, index) {
                      return AdminBlogCard(blog: controller.blogs![index]);
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

class AdminBlogCard extends StatelessWidget {
  final Blog blog;
  const AdminBlogCard({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align content at the top
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8), // Rounded corners for image
            child: Image.network(
              getImageUrl(blog.imageUrl),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Spread children vertically
              children: [
                Text(
                  blog.title ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 2, // Limit title to two lines
                  overflow: TextOverflow.ellipsis, // Ellipsis for overflow
                ),
                const SizedBox(height: 5),
                Text(
                  'Blog Posted: ${blog.blogDate ?? ''}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const DeleteBlogDialog(
                    blogId: 'blog_id',
                  ); // Instantiate and return your custom dialog
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class DeleteBlogDialog extends StatelessWidget {
  final String blogId;
  const DeleteBlogDialog({super.key, required this.blogId});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminBlogsController());
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure you want to delete it?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      controller.onDeleteClicked(blogId: blogId);
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('No'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
