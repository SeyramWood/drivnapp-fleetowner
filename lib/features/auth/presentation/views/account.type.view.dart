import 'package:drivn/features/auth/presentation/views/register_screen.dart';
import 'package:drivn/shared/utils/extentions/on.custom.elevated.button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../user/data/api/api.service.dart';
import '../widget/elevated.button.dart';

class AccountTypeView extends StatefulWidget {
  const AccountTypeView({super.key});

  @override
  State<AccountTypeView> createState() => _AccountTypeViewState();
}

class _AccountTypeViewState extends State<AccountTypeView> {
  void _setFleetOwner(bool isFleetOwner) {
    context.read<APIService>().isOwner(isFleetOwner);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const RegisterView(),
    ));
  }

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
                'Continue as a',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: () => _setFleetOwner(true),
                child: const Text('Fleet Owner'),
              ), 
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: () => _setFleetOwner(false),
                child: const Text('Driver'),
              ) 
            ],
          ),
        ),
      ),
    );
  }
}
