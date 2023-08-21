import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../widget/elevated.button.dart';

class AccountTypeView extends StatelessWidget {
  const AccountTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose to signup as a',
                style: Theme.of(context).textTheme.headlineMedium
              ),
              SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: () {},
                child: Text('Fleet Owner'),
              ),
              SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: () {},
                child: Text('Driver'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
