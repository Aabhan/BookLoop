// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PostBlogView extends GetView {
//   const PostBlogView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Post Blog'),
//         backgroundColor: const Color(0xff9CC69B),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               'Title',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.grey),
//               ),
//               child: const TextField(
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(12),
//                   hintText: 'Enter title...',
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'What do you want to write?',
//               style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey),
//                 ),
//                 child: const TextField(
//                   maxLines: null, // Allow multiple lines
//                   keyboardType: TextInputType.multiline,
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.all(12),
//                     hintText: 'Type here...',
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Implement logic to post the blog
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xff9CC69B), // Button color
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 2, horizontal: 15), // Button size
//                   ),
//                   icon: const Icon(Icons.send_rounded), // Icon
//                   label: const Text(
//                     'Post',
//                     style: TextStyle(fontSize: 18),
//                   ), // Text
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:ecom_2/app/model/blog.dart';
import 'package:ecom_2/app/modules/blog/controllers/blog_controller.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Import your HomeController

class PostBlogView extends GetView<BlogController> {
  const PostBlogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BlogController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Blog'),
        backgroundColor: const Color(0xff9CC69B),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: controller.addBlogFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextFormField(
                  controller: controller
                      .titleController, // Use controller for the title field
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: 'Enter title...',
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'What do you want to write?',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    controller: controller
                        .descriptionController, // Use controller for the description field
                    maxLines: null, // Allow multiple lines
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Type here...',
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 16),
              controller.blogImage == null || controller.imageBytes == null
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff9CC69B)),
                      onPressed: controller.onPickImage,
                      child: const Text('Upload Image'))
                  : Image.memory(controller.imageBytes!),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      if (controller.addBlogFormKey.currentState!.validate()) {
                        // Form is valid, implement logic to post the blog
                        // For example:
                        controller
                            .addBlog(); // Call the method to post the blog
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff9CC69B),
                      // Button color
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 15), // Button size
                    ),
                    icon: const Icon(Icons.send_rounded), // Icon
                    label: const Text(
                      'Post',
                      style: TextStyle(fontSize: 18),
                    ), // Text
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
