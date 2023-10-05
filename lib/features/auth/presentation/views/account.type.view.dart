import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/features/auth/presentation/views/login_screen.dart';
import 'package:drivn/shared/utils/extentions/on.custom.elevated.button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../widget/elevated.button.dart';

class AccountTypeView extends StatefulWidget {
  const AccountTypeView({super.key});

  @override
  State<AccountTypeView> createState() => _AccountTypeViewState();
}

class _AccountTypeViewState extends State<AccountTypeView> {
 
   _setAccountType(String isFleetOwner) async {
      context.read<UserAuthProvider>().isOwner(isFleetOwner);
      print(context.read<UserAuthProvider>().accountType);
    
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
                onPressed: () async {
                  LoadingDialog.showLoadingDialog(context);

                  await _setAccountType('fleet-owners').then(
                    (value) {
                      LoadingDialog.hideLoadingDialog(context);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ));
                    },
                  );
                },
                child: const Text('Fleet Owner'),
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: () async {
                  LoadingDialog.showLoadingDialog(context);
                  await _setAccountType('drivers').then(
                    (value) {
                      LoadingDialog.hideLoadingDialog(context);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginView(),
                      ));
                    },
                  );
                },
                child: const Text('Driver'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
