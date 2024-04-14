import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/admin_products/controllers/admin_products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProductCard extends StatelessWidget {
  final Product product;
  const UserProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
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
            getImageUrl(product.imageUrl),
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
                product.title ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                'Condition: ${product.isOld == '1' ? 'Old' : 'New'}',
                style: const TextStyle(
                  fontSize: 12, // Adjust font size as needed
                ),
              ),
              Text(
                'Negotiability: ${product.isNegotiable == '1' ? 'Negotiable' : 'Fixed'}',
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
