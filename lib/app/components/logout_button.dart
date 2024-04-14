import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogOutButton extends StatelessWidget {
  final String tittle;
  final void Function()? onPressed;
  const LogOutButton({super.key, required this.tittle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xff9CC69B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: SizedBox(
        height: 35,
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            const SizedBox(width: 5),
            Text(
              tittle,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
