import 'package:ecom_2/app/components/admin_product_card.dart';
import 'package:ecom_2/app/components/product_card.dart';
import 'package:ecom_2/app/components/user_product_card.dart';

import 'package:ecom_2/app/model/product.dart';

import 'package:ecom_2/app/modules/admin_categories/views/admin_categories_view.dart';
import 'package:ecom_2/app/modules/blog/views/blog_view.dart';
import 'package:ecom_2/app/modules/donate/views/donate_view.dart';
import 'package:ecom_2/app/modules/membership/views/membership_view.dart';
import 'package:ecom_2/app/modules/profile/views/profile_view.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/views/views/about_us_view.dart';
import 'package:ecom_2/app/views/views/categories_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.

          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(top: 30),
              height: 120,
              width: 120,
              decoration: const BoxDecoration(
                // image: DecorationImage(
                //     image: NetworkImage(
                //         'https://1000logos.net/wp-content/uploads/2016/10/Apple-Logo.png')),
                color: Color(0xff9CC69B),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  (controller.user?.fullName?[0].toUpperCase() ?? '') +
                      (controller.user?.fullName?[1].toUpperCase() ?? ''),
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Center(
                child: Text(
                  (controller.user?.fullName?.toUpperCase() ?? ''),
                ),
              ),
            ),
            const Divider(thickness: 2, height: 3),
            ListTile(
              title: const Text('Featured Products'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Categories'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CategoriesView(),
                    ));
              },
            ),
            ListTile(
              title: const Text('Blog'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BlogView(),
                    ));
              },
            ),
            ListTile(
              title: const Text('Donate Book'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DonateView()));
              },
            ),
            ListTile(
              title: const Text('Membership Plan'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MembershipView(),
                    ));
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileView(),
                    ));
              },
            ),
            ListTile(
              title: const Text('About US'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutUsView(),
                    ));
              },
            ),
          ],
        ),
      ),

      //App bar Starts from Here
      appBar: AppBar(
        title: const Text(
          'BookLoop',
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff9CC69B),
        actions: [
          IconButton(
            tooltip: 'Navigate to membership page',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MembershipView(),
                  ));
              // Your onPressed function goes here
            },
            icon: const Icon(Icons.group_add_rounded), // Wrap in Icon widget
          ),
        ],
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          if (controller.categories == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: SearchView(),
                              );
                            },
                            decoration: InputDecoration(
                              hintText: 'Search here',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),

                        //  <-----------------------Seacrh Icon  Button Starts from here---------------------------->
                        IconButton(
                          onPressed: () {
                            showSearch(
                              context: context,
                              delegate: SearchView(),
                            );
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categories?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_CATEGORY,
                                    arguments: controller.categories?[index]);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: const Color(0xff9CC69B)),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Center(
                                  child: Text(
                                    controller
                                            .categories?[index].categoryTitle ??
                                        '',
                                    style: const TextStyle(
                                        color: Color(0xff9CC69B)),
                                  ),
                                ),
                              ));
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  controller.products == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.products?.length ?? 0,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) => SizedBox(
                              width: 200,
                              child: ProductCard(
                                  product: controller.products![index])))
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff9CC69B),
        onPressed: controller.onUserAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}

HomeController controller = Get.put(HomeController());

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            Get.close(1);
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> suggestions = [];
    suggestions = controller.products
            ?.where((element) =>
                element.title?.toLowerCase().contains(query.toLowerCase()) ??
                false)
            .toList() ??
        [];

    return ListView.builder(
        shrinkWrap: true,
        itemCount: suggestions.length,
        itemBuilder: (context, index) => SizedBox(
              height: 100,
              child: UserProductCard(product: suggestions[index]),
            ));
  }
}
