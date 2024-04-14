import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallButton extends StatelessWidget {
  final String tittle;
  final void Function()? onPressed;
  final IconData iconData; // Icon to be displayed
  const CallButton(
      {Key? key, required this.tittle, required this.iconData, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff9CC69B),
          borderRadius: BorderRadius.circular(5),
        ),
        height: 50,
        width: 110,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: Colors.white,
              ),
              const SizedBox(
                  width: 8), // Adjust the spacing between the icon and text
              Text(
                tittle,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
