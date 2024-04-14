import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonateButton extends StatelessWidget {
  final String tittle;
  final void Function()? onPressed;
  const DonateButton({super.key, required this.tittle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xff9CC69B),
              borderRadius: BorderRadius.circular(10)),
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
