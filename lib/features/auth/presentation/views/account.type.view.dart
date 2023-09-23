import 'package:drivn/features/auth/presentation/views/login_screen.dart';
import 'package:drivn/shared/utils/extentions/on.custom.elevated.button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../../user/data/api/api.service.dart';
import '../widget/elevated.button.dart';

class AccountTypeView extends StatefulWidget {
  const AccountTypeView({super.key});

  @override
  State<AccountTypeView> createState() => _AccountTypeViewState();
}

class _AccountTypeViewState extends State<AccountTypeView> {
  bool _loadingOwner = false;
  bool _loadingDriver = false;
  Future _setFleetOwner(bool isFleetOwner) async {
    await Future.delayed(const Duration(seconds: 2), () {
      context.read<APIService>().isOwner(isFleetOwner);
      Navigator.of(context)
          .push(MaterialPageRoute(
        builder: (context) => const LoginView(),
      ))
          .then(
        (value) {
          setState(() {
            _loadingDriver = false;
            _loadingOwner = false;
          });
        },
      );
    });
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
                'I AM A',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: black),
              ),
              const SizedBox(height: 100),
              CustomElevatedButton(
                onPressed: () {
                  setState(() {
                    _loadingOwner = true;
                  });
                  _setFleetOwner(true);
                },
                child: const Text('Fleet Owner'),
              ).loading(_loadingOwner),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: () {
                  setState(() {
                    _loadingDriver = true;
                  });
                  _setFleetOwner(false);
                  // setState(() {
                  //   _loadingDriver = false;
                  // });
                },
                child: const Text('Driver'),
              ).loading(_loadingDriver)
            ],
          ),
        ),
      ),
    );
  }
}
