import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drivn/features/user/data/api/user.api.service.dart';
import 'package:drivn/features/user/domain/entities/owner.profile.model.dart';
import 'package:drivn/features/user/presentation/view/settings.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:drivn/shared/utils/constants/dimensions.dart';

import '../../../../shared/utils/extentions/on.custom.elevated.button.dart';
import '../../../auth/presentation/views/login_screen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<Profile> profile;

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  void getProfile() async {
    final userId = context.read<UserAuthProvider>().userID;
    final userProfile =
        UserApiService().fetchOwnerProfile(userId);
    setState(() {
      profile = userProfile;
    });
  }

  // Function to show the edit profile dialog
  void showEditProfileDialog(Profile profile) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        TextEditingController firstNameController =
            TextEditingController(text: profile.data.firstName);
        TextEditingController lastNameController =
            TextEditingController(text: profile.data.lastName);

        return AlertDialog(
          title: Center(
            child: Text(
              'Edit Profile',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 4,
              child: ElevatedButton(
                onPressed: () async {
                  var provider = context.read<UserAuthProvider>();
                  // Handle save button press and update profil4
                  final updatedFirstName = firstNameController.text;
                  final updatedLastName = lastNameController.text;
                  // Perform the update operation with the new data
                  LoadingDialog.showLoadingDialog(context);
                  await UserApiService()
                      .updateUser(
                          provider.userID,
                          '$updatedFirstName/$updatedLastName',
                          provider.accountType)
                      .then(
                    (value) {
                      LoadingDialog.hideLoadingDialog(context);
                      Navigator.pop(context);
                      getProfile();
                    },
                  );
                  // Close the dialog
                },
                child: const Text('Save'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Close the dialog without saving changes
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () async {
              showEditProfileDialog(await profile);
            },
            icon: const ImageIcon(
              AssetImage(AppIcons.edit),
              color: blue,
            ),
          ),
        ],
      ),
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
                                  fontSize: 20,
                                ),
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
                                    fontSize: 20,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              profile.username,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                    divider,
                    ListTile(
                      onTap: () {},
                      leading: const ImageIcon(
                        AssetImage(AppIcons.profile),
                      ),
                      title: const Text('My Profile'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    divider,
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Settings(),
                        ));
                      },
                      leading: const Icon(Icons.settings_outlined),
                      title: const Text('Settings'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    const Spacer(),
                    ListTile(
                      onTap: () {
                        LoadingDialog.showLoadingDialog(context);
                        Future.delayed(const Duration(seconds: 2), () {
                          LoadingDialog.hideLoadingDialog(context);
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ),
                            (route) => false,
                          );
                        });
                      },
                      leading: const ImageIcon(
                        AssetImage(AppIcons.logout),
                      ),
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
        },
      ),
    );
  }
}

class AppIcons {
  static const String edit = 'assets/icons/edit.png';
  static const String profile = 'assets/icons/profile.png';
  static const String logout = 'assets/icons/logout.png';
  // Add more image paths as needed
}
