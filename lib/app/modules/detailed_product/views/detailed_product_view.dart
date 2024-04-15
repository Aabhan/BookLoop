import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/product.dart';

import 'package:ecom_2/app/modules/cart/controllers/cart_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../controllers/detailed_product_controller.dart';

class DetailedProductView extends GetView<DetailedProductController> {
  const DetailedProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DetailedProductController());
    var product = Get.arguments as Product;
    // var rating = Get.arguments as Rating;
    var cartController = Get.find<CartController>();

    controller.getRating(product.productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title?.toUpperCase() ?? ''),
        backgroundColor: const Color(0xff9CC69B),
        centerTitle: true,
      ),
      body: GetBuilder<DetailedProductController>(
        builder: (controller) => SingleChildScrollView(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            width: double.infinity,
                            height: Get.height * 0.4,
                            getImageUrl(product.imageUrl ?? ''),
                            fit: BoxFit.contain,
                          ),
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title?.toUpperCase() ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 25,
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 2,
                                      height: 10,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 75,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundColor:
                                                    const Color(0xff9CC69B),
                                                child: Text(
                                                  (product.fullName?[0]
                                                              .toUpperCase() ??
                                                          '') +
                                                      (product.fullName?[1]
                                                              .toUpperCase() ??
                                                          ''),
                                                  style: const TextStyle(
                                                    fontSize: 35,
                                                    color: Colors.white,
                                                  ),
                                                ),

                                                // You can add a background image here if needed
                                              ),
                                              const SizedBox(width: 20),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    product.fullName
                                                            ?.toUpperCase() ??
                                                        '',
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    product.email ?? '',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    product.phoneNumber ?? '',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors
                                              .black, // You can adjust the color if needed
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: 'Description: ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: product.description ?? '',
                                            style: const TextStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              controller.callnumber(product);
                                            },
                                            icon: const Icon(
                                                Icons.call_outlined)),
                                        FavoriteIconButton(
                                          onPressed: () {
                                            cartController.addProduct(
                                                product: product);
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'General',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        // Icon for alignment
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[200],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Price: Rs.${product.price}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              // Icon for alignment
                                            ],
                                          ),
                                          const Divider(),
                                          Text(
                                            'Negotiable: ${product.isNegotiable == '1' ? 'Negotiable' : 'Fixed'}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          const Divider(),
                                          Text(
                                            'Condition: ${product.isOld == '1' ? 'Old' : 'New'}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          const Divider(),
                                          Text(
                                            'Location: ${product.userLocation}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Reviews:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor: Colors.amber,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7))),
                                              onPressed: () {
                                                _showReviewDialog(
                                                    context, product);
                                              },
                                              child: const Text(
                                                'Tap to Rate',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 200,
                                              child: Obx(() => ListView.builder(
                                                  itemCount:
                                                      controller.rating.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final rating = controller
                                                        .rating[index];
                                                    if (controller
                                                            .rating.length <=
                                                        3) {
                                                      return ReviewCard(
                                                          fullName:
                                                              rating.fullName ??
                                                                  '',
                                                          reviewText:
                                                              rating.reviews ??
                                                                  '',
                                                          rating:
                                                              rating.rating ??
                                                                  '');
                                                    }
                                                  })),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ])),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ]),
              );
            }
          }),
        ),
      ),
    );
  }
}

void _showReviewDialog(BuildContext context, Product product) {
  var detailProductController = Get.put(DetailedProductController());
  showDialog(
    context: context,
    builder: (BuildContext context) {
      double rating = 1; // Initial rating
      String review = ''; // Initial review

      return AlertDialog(
        title: Text('Give Review'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (newRating) {
                rating = newRating;
              },
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                review = value;
              },
              decoration: InputDecoration(
                hintText: 'Write your review...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Here, you can use the 'rating' and 'review' variables

              detailProductController.onRatingSubmit(
                  rating: rating, review: review, productId: product.productId);

              print('Rating: $rating, Review: $review');
              Navigator.of(context).pop();
            },
            child: Text('Submit'),
          ),
        ],
      );
    },
  );
}

class ReviewCard extends StatelessWidget {
  final String fullName;
  final String reviewText;
  final String rating;

  const ReviewCard({
    Key? key,
    required this.fullName,
    required this.reviewText,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                RatingBarIndicator(
                  rating: double.parse(rating),
                  itemBuilder: (context, index) =>
                      Icon(Icons.star, color: Colors.amber),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              reviewText,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteIconButton extends StatefulWidget {
  final Function onPressed;

  const FavoriteIconButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  _FavoriteIconButtonState createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  bool isInCart = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isInCart = !isInCart; // Toggle the favorite state
          widget.onPressed(); // Call the provided onPressed callback
        });
      },
      icon: isInCart
          ? const Icon(Icons.favorite,
              color: Colors.red) // If favorite, show filled heart icon
          : const Icon(
              Icons.favorite_outline,
              color: Colors.red,
            ), // Otherwise, show outline heart icon
    );
  }
}
