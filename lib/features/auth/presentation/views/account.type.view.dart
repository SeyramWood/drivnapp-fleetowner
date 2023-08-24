import 'package:drivn_app/features/auth/presentation/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../user/data/api/fleet.owner.api.dart';
import '../widget/elevated.button.dart';

class AccountTypeView extends StatelessWidget {
  const AccountTypeView({super.key});

  void _setFleetOwner(bool isFleetOwner, BuildContext context) {
    context.read<APIService>().fleetOwner(isFleetOwner);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => RegisterView(),
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
              Text('Continue as a',
                  style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: () => _setFleetOwner(true, context),
                child: Text('Fleet Owner'),
              ),
              SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: () => _setFleetOwner(false, context),
                child: Text('Driver'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
