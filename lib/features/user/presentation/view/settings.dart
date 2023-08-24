import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/dimensions.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const SafeArea(
          child: Column(
        children: [
          ListTile(
            title: Text('Two step verification',),
            subtitle: Text('No'),
          ),
          divider,
          ListTile(
            title: Text('Security Unlock'),
            subtitle: Text('Pin'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          divider,
          ListTile(
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          divider,
          ListTile(
            title: Text('Terms and Conditions'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      )),
    );
  }
}
