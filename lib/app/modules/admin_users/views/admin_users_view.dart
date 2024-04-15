import 'package:ecom_2/app/components/My_button.dart';
import 'package:ecom_2/app/model/user.dart';
import 'package:ecom_2/app/modules/home/views/home_view.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_users_controller.dart';

class AdminUsersView extends GetView<AdminUsersController> {
  const AdminUsersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('User Details'),
        centerTitle: true,
      ),
      body: GetBuilder<AdminUsersController>(
        init: AdminUsersController(),
        builder: (controller) {
          if (controller.users == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var adminUsers = controller.users
                  ?.where((user) => user.role == 'admin')
                  .toList() ??
              [];

          var normalUsers =
              controller.users?.where((user) => user.role == 'user').toList() ??
                  [];
          return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    labelStyle: TextStyle(color: Colors.teal, fontSize: 22),
                    tabs: [
                      Tab(
                        child: Text(
                          'Users',
                          style: TextStyle(color: Colors.teal),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Admins',
                          style: TextStyle(color: Colors.teal),
                        ),
                      ),
                    ],
                    indicatorColor: Colors.teal,
                  ),
                  Expanded(
                      child: TabBarView(
                    children: [
                      ListView.builder(
                        itemCount: normalUsers.length,
                        itemBuilder: (context, index) => UserCard(
                          user: normalUsers[index],
                        ),
                      ),
                      ListView.builder(
                          itemCount: adminUsers.length,
                          itemBuilder: (context, index) =>
                              UserCard(user: adminUsers[index]))
                    ],
                  ))
                ],
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const AddUserPopup());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({super.key, required this.user});

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
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fullName ?? '',
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                user.email ?? '',
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Role: ${user.role?.toUpperCase() ?? ''}',
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete User'),
                    content: const Text(
                        'Are you sure ,you want to delete this user'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          controller.deleteUser(user.userId);
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('No'),
                      ),
                    ],
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

class AddUserPopup extends StatelessWidget {
  const AddUserPopup({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AdminUsersController>();
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Admin',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: controller.nameController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Admin name',
                  hintText: 'Enter admin name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter admin name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: controller.emailController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Admin email',
                  hintText: 'Enter admin email address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter admin email';
                  } else if (!value.isEmail) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                obscureText: true,
                controller: controller.passwordController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Admin password',
                  hintText: 'Enter admin initial password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter admin password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              AddAdminButton(tittle: 'Add Admin', onPressed: controller.addUser)
            ],
          ),
        ),
      ),
    );
  }
}

class AddAdminButton extends StatelessWidget {
  final String tittle;
  final void Function()? onPressed;
  const AddAdminButton({super.key, required this.tittle, this.onPressed});

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
