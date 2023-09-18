import 'package:drivn/features/driver/presentation/views/main.page.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/dimensions.dart';
import '../widget/elevated.button.dart';

class VerifyingView extends StatelessWidget {
  const VerifyingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verifying')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/icons/Vector.png',
                  ),
                  scale: 1.5),
              shape: BoxShape.circle,
              color: blue,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Checking your documents',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(9),
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: black),
              child: const Text(
                '1',
                style: TextStyle(color: white, fontSize: 15),
              ),
            ),
            title: const Text('Verifying national id'),
            trailing: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: grey,
                ),
                child: const Icon(
                  Icons.done_outlined,
                  size: 20,
                  color: white,
                )),
          ),
          divider,
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(9),
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: black),
              child: const Text(
                '2',
                style: TextStyle(color: white, fontSize: 15),
              ),
            ),
            title: const Text('Verifying driving licence'),
            trailing: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: grey,
                ),
                child: const Icon(
                  Icons.done_outlined,
                  size: 20,
                  color: white,
                )),
          ),
          divider,
          const SizedBox(height: 60),
          SizedBox(
            width: 150,
            child: CustomElevatedButton(
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const DMainPage(),
                  ),
                  (route) => false),
              child: const Text('Go Home'),
            ),
          )
        ],
      ),
    );
  }
}
