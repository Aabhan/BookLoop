import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsView extends GetView {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
        backgroundColor: const Color(0xff9CC69B),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Add your image here
            Image.asset(
              'assets/BookLoopLogo.png', // Replace with your image path
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'About Book Loop',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Pellentesque ut arcu et est vehicula volutpat. Nullam ac '
              'convallis arcu, ac sollicitudin risus. Proin ut ipsum ac orci '
              'lobortis maximus. Vivamus gravida urna eu mi varius, sed '
              'porta nulla eleifend. Ut congue nunc ac semper luctus.'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Pellentesque ut arcu et est vehicula volutpat. Nullam ac '
              'convallis arcu, ac sollicitudin risus. Proin ut ipsum ac orci '
              'lobortis maximus. Vivamus gravida urna eu mi varius, sed '
              'porta nulla eleifend. Ut congue nunc ac semper luctus.'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Pellentesque ut arcu et est vehicula volutpat. Nullam ac '
              'convallis arcu, ac sollicitudin risus. Proin ut ipsum ac orci '
              'lobortis maximus. Vivamus gravida urna eu mi varius, sed '
              'porta nulla eleifend. Ut congue nunc ac semper luctus.'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Pellentesque ut arcu et est vehicula volutpat. Nullam ac '
              'convallis arcu, ac sollicitudin risus. Proin ut ipsum ac orci '
              'lobortis maximus. Vivamus gravida urna eu mi varius, sed '
              'porta nulla eleifend. Ut congue nunc ac semper luctus.'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Pellentesque ut arcu et est vehicula volutpat. Nullam ac '
              'convallis arcu, ac sollicitudin risus. Proin ut ipsum ac orci '
              'lobortis maximus. Vivamus gravida urna eu mi varius, sed '
              'porta nulla eleifend. Ut congue nunc ac semper luctus.',
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            const Text(
              'Our Vision',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'lobortis maximus. Vivamus gravida urna eu mi varius, sed '
              'porta nulla eleifend. Ut congue nunc ac semper luctus.'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Pellentesque ut arcu et est vehicula volutpat. Nullam ac '
              'convallis arcu, ac sollicitudin risus. Proin ut ipsum ac orci '
              'lobortis maximus. Vivamus gravida urna eu mi varius, sed '
              'porta nulla eleifend. Ut congue nunc ac semper luctus.'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Pellentesque ut arcu et est vehicula volutpat. Nullam ac '
              'convallis arcu, ac sollicitudin risus. Proin ut ipsum ac orci '
              'lobortis maximus. Vivamus gravida urna eu mi varius, sed '
              'porta nulla eleifend. Ut congue nunc ac semper luctus.',
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 40),
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Email: example@example.com\n'
              'Phone: +1234567890\n'
              'Address: 123 Main Street, City, Country',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
