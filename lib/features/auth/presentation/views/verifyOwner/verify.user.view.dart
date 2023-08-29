import 'package:drivn/features/owner/presentations/views/home.dart';
import 'package:drivn/features/auth/presentation/views/verifyOwner/identity.info.view.dart';
import 'package:drivn/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_screen.dart';
import 'driver.doc.dart';

class GetVerifiedOption extends StatelessWidget {
  const GetVerifiedOption({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<APIService>();
    return Scaffold(
        backgroundColor: blue,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Before you rent out a car, let’s get you verified',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: 20)),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'We need to check that you are really you. It helps us fight fraud and keep cars secured.',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 15),
                ),
                const SizedBox(
                  height: 15,
                ),
                //proof identity
                Card(
                  color: white,
                  child: ListTile(
                    onTap: () {
                      provider.setfield('idCard');
                      provider.setPath('proof-identity');
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProofIDView(),
                      ));
                    },
                    leading: const ImageIcon(
                      AssetImage('assets/icons/license.png'),
                      // size: 45,
                      color: yellow,
                    ),
                    title: const Text(
                      'Proof of Identity',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text(
                      'Upload a passport,national ID...',
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  color: white,
                  child: ListTile(
                    onTap: () {
                      provider.setfield('documents');
                      provider.setPath('drivers-document');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const DriverDocsView(),
                        ),
                      );
                    },
                    leading: const ImageIcon(
                      AssetImage('assets/icons/driving.png'),
                      color: yellow,
                    ),
                    title: const Text(
                      'Driving Documents',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text(
                      'Upload a valid driving license...',
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const OMainPage(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Text(
                      'Later',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: white),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 6,
                ),
                CustomElevatedButton(
                  backgroundColor: black,
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginView()),
                      (route) => false),
                  child: const Text('Done'),
                )
              ],
            ),
          ),
        ));
  }
}
