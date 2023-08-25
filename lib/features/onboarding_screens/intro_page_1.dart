import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 16,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  // padding: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Image.asset(
                    'assets/step_1_image.png', // Replace with your image path
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    'Endless options',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: black, fontSize: 30),
                  ),
                ),
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Sed aliquam risus sit amet turpis dictum, in ultrices odio '
                    'lobortis. Nulla facilisi. Suspendisse at tempor lectus.',
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
