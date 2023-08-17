import 'package:drivn_app/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/dimensions.dart';
import '../widget/elevated.button.dart';

class VerifyingView extends StatelessWidget {
  const VerifyingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verifying')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: blue,
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Checking your documents',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 30),
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(shape: BoxShape.circle, color: black),
              child: Text(
                '1',
                style: TextStyle(color: white, fontSize: 15),
              ),
            ),
            title: Text('asdfghkl'),
            trailing: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: grey,
                ),
                child: Icon(
                  Icons.done_outlined,
                  size: 20,
                  color: white,
                )),
          ),
          divider,
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(shape: BoxShape.circle, color: black),
              child: Text(
                '2',
                style: TextStyle(color: white, fontSize: 15),
              ),
            ),
            title: Text('asdfghkl'),
            trailing: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: grey,
                ),
                child: Icon(
                  Icons.done_outlined,
                  size: 20,
                  color: white,
                )),
          ),
          divider,
          SizedBox(height: 60),
          SizedBox(
            width: 150,
            child: CustomElevatedButton(
              onPressed: () => () {},
              child: Text('Go Home'),
            ),
          )
        ],
      ),
    );
  }
}
