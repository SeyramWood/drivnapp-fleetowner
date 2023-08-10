import 'package:drivn_app/features/user/presentation/view/settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../../../shared/utils/constants/dimensions.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final icons = [
    ImageIcon(AssetImage('assets/icons/license.png')),
    ImageIcon(AssetImage('assets/icons/gov_id.png')),
    ImageIcon(AssetImage('assets/icons/others.png')),
  ];
  final title = ['License', "Gov'tID", 'Others'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 20),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/car1.png'),
                    radius: 35,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Row(
                        children: [
                          Text(
                            'Edit profile',
                            style: TextStyle(color: red),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width / 3,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: ImageIcon(
                                AssetImage('assets/icons/edit.png'),
                                color: blue,
                              )),
                        ],
                      )
                    ],
                  ),
                ],
              ), //end of profile tile
              divider,
              Row(
                children: List.generate(
                  3,
                  (index) => Card(
                    elevation: 0,
                    color: white,
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            icons[index],
                            Text(title[index]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              divider,
              ListTile(
                onTap: () {},
                leading: ImageIcon(
                  AssetImage('assets/icons/profile.png'),
                ),
                title: Text('My Profile'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              divider,
              ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Settings(),
                )),
                leading: Icon(Icons.settings_outlined),
                title: Text('Settings'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              Spacer(),
              ListTile(
                onTap: () {},
                leading: ImageIcon(AssetImage('assets/icons/logout.png')),
                title: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
