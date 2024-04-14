import 'package:ecom_2/app/components/My_button.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../model/category.dart';
import '../controllers/admin_categories_controller.dart';

class AdminCategoriesView extends GetView<AdminCategoriesController> {
  const AdminCategoriesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Categories'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
              if (controller.categories == null) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: controller.categories!.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                        category: controller.categories![index]);
                  });
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return const AddCategoryPopup();
                });
          },
          child: const Icon(Icons.add),
        ));
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category.categoryTitle ?? '',
            style: const TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => DeleteCategoryDialog(
                    categoryId: category.categoryId ?? '',
                  ),
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}

class AddCategoryPopup extends StatelessWidget {
  const AddCategoryPopup({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.addCategoryFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Category',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: controller.categoryNameController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Category Title',
                  hintText: 'Enter category title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category title';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              AddAdminCategoryButton(
                  tittle: 'Add Category', onPressed: controller.addCategory)
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteCategoryDialog extends StatelessWidget {
  final String categoryId;
  const DeleteCategoryDialog({super.key, required this.categoryId});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminCategoriesController());
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure you want to delete Category?',
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
                      controller.onDeleteClicked(categoryId: categoryId);
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

class AddAdminCategoryButton extends StatelessWidget {
  final String tittle;
  final void Function()? onPressed;
  const AddAdminCategoryButton(
      {super.key, required this.tittle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.teal, borderRadius: BorderRadius.circular(10)),
          height: 50,
          width: Get.width,
          child: Center(
              child: Text(
            tittle,
            style: const TextStyle(color: Colors.white),
          )),
        ));
  }
}
