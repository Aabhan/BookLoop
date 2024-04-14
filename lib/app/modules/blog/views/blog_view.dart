import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/blog.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/views/views/post_blog_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/blog_controller.dart';

class BlogView extends GetView<BlogController> {
  const BlogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BlogController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff9CC69B),
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
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Featured Blogs',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => const PostBlogView());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff9CC69B),
                            foregroundColor: Colors.white,
                            elevation: 2,
                          ),
                          child: const Text('+ Post Blog'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                    height:
                        16), // Add some spacing between the button and the blog list
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.blogs!.length,
                    itemBuilder: (context, index) {
                      return BlogCard(blog: controller.blogs![index]);
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),

      // body: Padding(
      //   padding: const EdgeInsets.all(13.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Padding(
      //           padding: const EdgeInsets.only(top: 16.0),
      //           child: Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment
      //                     .spaceBetween, // Adjust this property as needed
      //                 children: [
      //                   const Text(
      //                     'Featured Blogs',
      //                     style: TextStyle(
      //                       fontSize: 24,
      //                       fontWeight: FontWeight.w400,
      //                     ),
      //                   ),
      //                   ElevatedButton(
      //                     onPressed: () {
      //                       Navigator.push(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) => const PostBlogView(),
      //                           ));
      //                     },
      //                     style: ElevatedButton.styleFrom(
      //                       backgroundColor:
      //                           const Color(0xff9CC69B), // Background color
      //                       foregroundColor: Colors.white, // Text color
      //                       elevation: 2, // Elevation
      //                     ),
      //                     child: const Text('+ Post Blog'),
      //                   ),
      //                 ],
      //               )))
      //     ],
      //   ),
      // ),
    );
  }
}

class BlogCard extends StatelessWidget {
  final Blog blog;
  const BlogCard({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL_BLOG, arguments: blog);
      },
      child: Container(
        height: 75,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white, // Ensure sufficient contrast for text visibility
          boxShadow: [
            BoxShadow(
              color: const Color(0xff9CC69B).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.network(
              getImageUrl(blog.imageUrl),
              width: 75,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Blog Posted: ${blog.blogDate ?? ''}', // Ensure blogDate is not null
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Colors
                            .grey, // Optionally, you can style the time posted differently
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       blog.title ?? '', // Ensure title is not null
        //       style: const TextStyle(
        //         fontWeight: FontWeight.bold,
        //         fontSize: 20,
        //       ),
        //     ),
        //     const SizedBox(height: 10),
        //     Flexible(
        //       child: Text(
        //         blog.blogDecscription ?? '', // Ensure description is not null
        //         style: const TextStyle(
        //           fontWeight: FontWeight.w200,
        //           fontSize: 15,
        //         ),
        //         overflow: TextOverflow.fade,
        //         maxLines: 3,
        //       ),
        //     ),
        //     const SizedBox(height: 10),
        //     Text(
        //       'Time Posted: ${blog.blogDate ?? ''}', // Ensure blogDate is not null
        //       style: const TextStyle(
        //         fontWeight: FontWeight.w400,
        //         fontSize: 12,
        //         color: Colors
        //             .grey, // Optionally, you can style the time posted differently
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
