import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../../auth/presentation/views/login_screen.dart';

class DProfileView extends StatelessWidget {
  const DProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              'Edit',
              style: TextStyle(color: yellow),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const CircleAvatar(
            radius: 40,
          ),
          const SizedBox(height: 10),
          const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Class B',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          const ListTile(
            title: Text('Email'),
            subtitle: Text('john.doe@example.com'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const Divider(),
          const ListTile(
            title: Text('Phone'),
            subtitle: Text('+1234567890'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const Divider(),
          const ListTile(
            title: Text('Location'),
            subtitle: Text('City, Country'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const Spacer(),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );

              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginView(),
                  ),
                  (route) => false,
                );
              });
            },
            leading: const ImageIcon(AssetImage('assets/icons/logout.png')),
            title: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
// 
