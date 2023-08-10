import 'package:drivn_app/app/home.dart';
import 'package:drivn_app/features/auth/presentation/views/verifyOwner/identity.info.view.dart';
import 'package:drivn_app/features/auth/presentation/widget/elevated.button.dart';
import 'package:drivn_app/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';
import 'driver.doc.dart';

class GetVerifiedOption extends StatelessWidget {
  const GetVerifiedOption({super.key});

  @override
  Widget build(BuildContext context) {
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
                SizedBox(
                  height: 15,
                ),
                Text(
                  'We need to check that you are really you. It helps us fight fraud and keep cars secured.',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 15),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  color: white,
                  child: ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProofIDView(),
                    )),
                    leading: ImageIcon(
                      AssetImage('assets/icons/license.png'),
                      // size: 45,
                      color: yellow,
                    ),
                    title: Text(
                      'Proof of Identity',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Upload a passport,national ID...',
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: white,
                  child: ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DriverDocsView(),
                    ),),
                    leading: ImageIcon(
                      AssetImage('assets/icons/driving.png'),
                      color: yellow,
                    ),
                    title: Text(
                      'Driving Documents',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Upload a valid driving license...',
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(
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
                          builder: (context) => HomePage(),
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
                      MaterialPageRoute(builder: (context) => LoginView()),
                      (route) => false),
                  child: Text('Done'),
                )
              ],
            ),
          ),
        ));
  }
}
