import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';

class DProfileView extends StatelessWidget {
  const DProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Text(
            'Edit',
            style: TextStyle(color: yellow),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          CircleAvatar(radius: 40),
          Text('John Doe'),
          Text('class B'),
          ListTile(
            title: Text('UserName'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('UserName'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('UserName'),
            trailing: Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }
}
