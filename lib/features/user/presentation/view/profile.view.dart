import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/features/user/data/api/user.api.service.dart';
import 'package:drivn/features/user/domain/entities/owner.profile.model.dart';
import 'package:drivn/features/user/presentation/view/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../../../shared/utils/constants/dimensions.dart';
import '../../../auth/presentation/views/login_screen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final icons = [
    const ImageIcon(AssetImage('assets/icons/license.png')),
    const ImageIcon(AssetImage('assets/icons/gov_id.png')),
    const ImageIcon(AssetImage('assets/icons/others.png')),
  ];
  final title = ['License', "Gov'tID", 'Others'];
  late Future<Profile> profile;
  void getProfile() async {
    var id = context.read<UserApiService>().userId;
    var userProfile = context
        .read<UserApiService>()
        .fetchOwnerProfile(context.read<UserApiService>().userId);
    profile = userProfile;
    // profile=  userProfile.fold(
    //     (l) => ,
    //     (r) {
    //       profile = r;
    //       return r;
    //     },
    // );
    // if (userProfile is Profile) {
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Profile>(
          future: profile,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              final profile = snapshot.data!.data;
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0)
                      .copyWith(top: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            child: Text(
                              '${profile.firstName[0]} ${profile.lastName[0]}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${profile.firstName} ${profile.lastName}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Edit profile',
                                    style: TextStyle(color: red),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width / 3,
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const ImageIcon(
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
                            child: SizedBox(
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
                        leading: const ImageIcon(
                          AssetImage('assets/icons/profile.png'),
                        ),
                        title: const Text('My Profile'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      divider,
                      ListTile(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Settings(),
                        )),
                        leading: const Icon(Icons.settings_outlined),
                        title: const Text('Settings'),
                        trailing: const Icon(Icons.arrow_forward_ios),
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
                        leading: const ImageIcon(
                            AssetImage('assets/icons/logout.png')),
                        title: const Text('Logout'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
