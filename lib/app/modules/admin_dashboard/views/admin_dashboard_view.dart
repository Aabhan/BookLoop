import 'package:ecom_2/app/components/My_button.dart';
import 'package:ecom_2/app/components/adminViewOrderButton.dart';
import 'package:ecom_2/app/modules/admin_blogs/views/admin_blogs_view.dart';
import 'package:ecom_2/app/modules/admin_orders/views/admin_orders_view.dart';
import 'package:ecom_2/app/modules/admin_products/views/admin_products_view.dart';
import 'package:ecom_2/app/modules/admin_users/views/admin_users_view.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_dashboard_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Set dark theme
      home: const AdminDashboardView(),
    );
  }
}

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<AdminDashboardController>(
              init: AdminDashboardController(),
              builder: (controller) {
                if (controller.stats == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await controller.getStats();
                  },
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    padding: const EdgeInsets.all(6),
                    children: [
                      GestureDetector(
                        // onTap: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               const AdminOrdersView()));
                        // },
                        child: StatsCard(
                          label: 'Total Income',
                          icon: const Icon(Icons.money_outlined),
                          isAmount: true,
                          value: controller.stats?.totalIncome.toString() ?? '',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminUsersView()));
                        },
                        child: StatsCard(
                          label: 'Total Users',
                          icon: const Icon(Icons.person_outline_outlined),
                          value: controller.stats?.totalUsers.toString() ?? '',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminProductsView()));
                        },
                        child: StatsCard(
                          label: 'Total Products',
                          icon: const Icon(Icons.book_outlined),
                          value:
                              controller.stats?.totalProducts.toString() ?? '',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminOrdersView()));
                        },
                        child: StatsCard(
                          label: 'Total Orders',
                          icon: const Icon(Icons.list),
                          value: controller.stats?.totalOrders.toString() ?? '',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminBlogsView()));
                        },
                        child: StatsCard(
                          label: 'Total Blogs',
                          icon: const Icon(Icons.article_outlined),
                          value: controller.stats?.totalBlog.toString() ?? '',
                        ),
                      ),
                      StatsCard(
                        label: 'Total Donation',
                        icon: const Icon(Icons.bookmark_add_outlined),
                        value: controller.stats?.totalDonation.toString() ?? '',
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          // AdminViewOrderButton(
          //   tittle: 'View Orders',
          //   onPressed: () {
          //     Get.toNamed(Routes.ADMIN_ORDERS);
          //   },
          // )
        ],
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String label;
  final String value;
  final Icon? icon;
  final bool isAmount;
  final Color? color;

  const StatsCard({
    super.key,
    required this.label,
    required this.value,
    this.isAmount = false,
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            (isAmount ? 'Rs.' : '') + value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                ),
              ),
              icon ?? const SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }
}
