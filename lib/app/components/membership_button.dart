import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MembershipButton extends StatelessWidget {
  final String tittle;
  final void Function()? onPressed;
  const MembershipButton({super.key, required this.tittle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
              // border: Border.all(color: Colors.black),
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(10)),
          height: 50,
          width: 200,
          child: Center(
              child: Text(
            tittle,
            style: const TextStyle(color: Colors.white),
          )),
        ));
  }
}
