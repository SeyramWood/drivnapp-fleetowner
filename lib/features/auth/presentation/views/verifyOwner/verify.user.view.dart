import 'package:drivn_app/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

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
                    style: Theme.of(context).textTheme.headlineLarge),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .1,
                ),
                Text(
                    'We need to check that you are really you. It helps us fight fraud and keep cars secured.',
                    style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(
                  height: 10,
                ),
                Card(
                  color: white,
                  child: ListTile(
                    leading: Icon(
                      Icons.info,
                      size: 45,
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
                Card(
                  color: white,
                  child: ListTile(
                    leading: Icon(
                      Icons.car_rental,
                      size: 45,
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
                    onPressed: () {},
                    child: Text(
                      'Later',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
