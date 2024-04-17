import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Form(
              key: controller.registerFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    "assets/BookLoopLogo.png",
                    height: 250,
                  ),
                  // Add your logo image here if needed
                  // Image.network(
                  //   'https://i.pngimg.me/thumb/f/720/2f399e026c1e46b98abe.jpg',
                  //   height: 200,
                  //   width: 200,
                  // ),
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: controller.fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Full name',
                      hintText: 'Enter full name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                      hintText: 'Enter your email address',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      } else if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 25),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      hintText: 'Choose your location',
                      border: OutlineInputBorder(),
                    ),
                    items: controller.userLocation.map((String userLocation) {
                      return DropdownMenuItem<String>(
                        value: userLocation,
                        child: Text(userLocation),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      controller.userLocationController.text = newValue ?? '';
                    },
                    value: controller.userLocationController.text.isEmpty
                        ? null
                        : controller.userLocationController.text,
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: controller.phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      hintText: 'Enter your phone number',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (value.length < 10) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 25),
                  TextFormField(
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xff9CC69B), // Change button color here
                      minimumSize:
                          const Size(double.infinity, 50), // Set button size
                    ),
                    onPressed: controller.onRegister,
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xff9CC69B),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
