import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminViewOrderButton extends StatelessWidget {
  final String tittle;
  final void Function()? onPressed;
  const AdminViewOrderButton({super.key, required this.tittle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.teal, borderRadius: BorderRadius.circular(10)),
          height: 50,
          width: 100,
          child: Center(
              child: Text(
            tittle,
            style: const TextStyle(color: Colors.white),
          )),
        ));
  }
}
