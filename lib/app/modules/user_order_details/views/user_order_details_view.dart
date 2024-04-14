import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/userOrder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_order_details_controller.dart';

class UserOrderDetailsView extends StatelessWidget {
  const UserOrderDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: const Color(0xff9CC69B),
        centerTitle: true,
      ),
      body: GetBuilder<UserOrderDetailsController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : controller.orderDetails.isEmpty
                      ? Center(
                          child: Text(
                            'No order details found',
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.orderDetails.length,
                          itemBuilder: (context, index) {
                            final orderDetail = controller.orderDetails[index];

                            return OrderDetailCard(
                              orderDetails: orderDetail,
                            );
                          },
                        ),
            ),
          );
        },
      ),
    );
  }
}

class OrderDetailCard extends StatelessWidget {
  final OrderDetails orderDetails;
  const OrderDetailCard({super.key, required this.orderDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff9CC69B).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Image.network(
            getImageUrl(orderDetails.imageUrl),
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
                orderDetails.title ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Paid: ${orderDetails.price ?? ''}',
                style: const TextStyle(
                  fontSize: 12, // Adjust font size as needed
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Order ID : #${orderDetails.orderId ?? ''}',
                style: const TextStyle(
                  fontSize: 12, // Adjust font size as needed
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Order Status : ${orderDetails.status ?? ''}',
                style: const TextStyle(
                  fontSize: 12, // Adjust font size as needed
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Order Date : ${orderDetails.orderDate ?? ''}',
                style: const TextStyle(
                  fontSize: 12, // Adjust font size as needed
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
