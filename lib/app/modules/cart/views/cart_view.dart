import 'package:ecom_2/app/components/call_button.dart';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/modules/checkout/views/checkout_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favourites'),
          backgroundColor: const Color(0xff9CC69B),
          centerTitle: true,
        ),
        body: GetBuilder<CartController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.cart.length,
                      itemBuilder: (context, index) => CartCard(
                            cartItem: controller.cart[index],
                            index: index,
                          )),
                ),
                // Container(
                //   width: double.infinity,
                //   padding: const EdgeInsets.all(10),
                //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
                //     BoxShadow(
                //       color: Colors.grey.withOpacity(0.5),
                //       spreadRadius: 5,
                //       blurRadius: 7,
                //     ),
                //   ]),
                //   child: Column(
                //     children: [
                //       const Text(
                //         'Your total:',
                //         style: TextStyle(
                //             fontSize: 20, fontWeight: FontWeight.bold),
                //       ),
                //       Obx(
                //         () => Text(
                //           'Rs. ${controller.total.value}',
                //           style: const TextStyle(
                //               fontSize: 20, fontWeight: FontWeight.bold),
                //         ),
                //       ),
                //       TextButton(
                //         onPressed: () async {
                //           if (controller.cart.isEmpty) {
                //             Get.showSnackbar(const GetSnackBar(
                //               backgroundColor: Colors.red,
                //               message: 'Cart is empty!',
                //               duration: Duration(seconds: 3),
                //             ));
                //             return;
                //           }
                //           var orderId = await controller.makeOrder();
                //           if (orderId == null) {
                //             return;
                //           }
                //           KhaltiScope.of(Get.context!).pay(
                //             preferences: [
                //               PaymentPreference.khalti,
                //               PaymentPreference.connectIPS
                //             ],
                //             config: PaymentConfig(
                //               amount: 1000,
                //               productIdentity: orderId.toString(),
                //               productName: "My Product",
                //             ),
                //             onSuccess: (PaymentSuccessModel v) {
                //               controller.makePayment(
                //                   total: (v.amount / 100).toString(),
                //                   orderId: orderId.toString(),
                //                   otherData: v.toString());
                //             },
                //             onFailure: (v) {
                //               Get.showSnackbar(const GetSnackBar(
                //                 backgroundColor: Colors.red,
                //                 message: 'Payment failed!',
                //                 duration: Duration(seconds: 3),
                //               ));
                //             },
                //             onCancel: () {
                //               Get.showSnackbar(const GetSnackBar(
                //                 backgroundColor: Colors.red,
                //                 message: 'Payment cancelled!',
                //                 duration: Duration(seconds: 3),
                //               ));
                //             },
                //           );
                //         },
                //         child: Container(
                //             padding: const EdgeInsets.all(10),
                //             margin: const EdgeInsets.all(10),
                //             decoration: BoxDecoration(
                //                 color: Colors.white,
                //                 borderRadius: BorderRadius.circular(10),
                //                 boxShadow: [
                //                   BoxShadow(
                //                     color: Colors.grey.withOpacity(0.5),
                //                     spreadRadius: 5,
                //                     blurRadius: 7,
                //                   ),
                //                 ]),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Image.network(
                //                     'https://upload.wikimedia.org/wikipedia/commons/e/ee/Khalti_Digital_Wallet_Logo.png.jpg',
                //                     height: 30),
                //                 Text('Pay with Khalti'),
                //               ],
                //             )),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ));
  }
}

class CartCard extends StatelessWidget {
  final CartItem cartItem;
  final int index;
  const CartCard({Key? key, required this.cartItem, required this.index});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            height: 120, // Increased height for better spacing
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        getImageUrl(cartItem.product.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cartItem.product.title ?? '',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Price: ${cartItem.product.price}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 26,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    controller.removeProduct(index);
                  },
                  icon: const Icon(Icons.clear, color: Colors.red),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Get.to(() => CheckoutView());
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
