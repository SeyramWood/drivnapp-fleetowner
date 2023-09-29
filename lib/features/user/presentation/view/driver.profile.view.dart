import 'package:drivn/features/auth/presentation/views/validating.view.dart';
import 'package:drivn/features/user/data/api/user.api.service.dart';
import 'package:drivn/features/user/domain/entities/driver.profile.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../../auth/presentation/views/login_screen.dart';
import '../../../../shared/utils/constants/dimensions.dart';

class DProfileView extends StatefulWidget {
  const DProfileView({super.key});

  @override
  State<DProfileView> createState() => _DProfileViewState();
}

class _DProfileViewState extends State<DProfileView> {
  late Future<DProfile> profileData;
  getProfile() {
    final userId = context.read<UserApiService>().userId;

    final data = context.read<UserApiService>().fetchDriverProfile(userId);
    setState(() {
      profileData = data;
    });
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  void showEditProfileDialog(DProfile profile) {
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
                  // Handle save button press and update profil4
                  final updatedFirstName = firstNameController.text;
                  final updatedLastName = lastNameController.text;
                  // Perform the update operation with the new data
                  await context
                      .read<UserApiService>()
                      .updateUser(context.read<UserApiService>().userId,
                          '$updatedFirstName/$updatedLastName')
                      .then(
                    (value) {
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
    return FutureBuilder<DProfile>(
        future: profileData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.hasData) {
            final profile = snapshot.data!.data;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                    onPressed: () async {
                      // Show the edit profile dialog when the edit icon is pressed

                      showEditProfileDialog(await profileData);
                    },
                    icon: const ImageIcon(
                      AssetImage('assets/icons/edit.png'),
                      color: blue,
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .01,
                  ),
                  CircleAvatar(
                    radius: 60,
                    child: Text(
                      '${profile.firstName[0]}${profile.lastName[0]}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .01,
                  ),
                  Text(
                    '${profile.firstName} ${profile.lastName}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 18),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .01,
                  ),
                  Text(
                    'Class ${profile.document?.licenseType}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .02,
                  ),
                  // ListTile(
                  //   title: Text(
                  //     'Email',
                  //     style: Theme.of(context).textTheme.bodyLarge,
                  //   ),
                  //   subtitle: Text(
                  //     'john.doe@example.com',
                  //     style: Theme.of(context).textTheme.bodyMedium,
                  //   ),
                  //   // trailing: Icon(Icons.arrow_forward_ios),
                  // ),
                  // divider,
                  ListTile(
                    title: Text(
                      'Email/Phone',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      profile.username,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    // trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  divider,
                  // ListTile(
                  //   title: Text(
                  //     'Location',
                  //     style: Theme.of(context).textTheme.bodyLarge,
                  //   ),
                  //   subtitle: Text(
                  //     '',
                  //     style: Theme.of(context).textTheme.bodyMedium,
                  //   ),
                  //   // trailing: Icon(Icons.arrow_forward_ios),
                  // ),
                  // divider,
                  ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const VerifyingView(),
                    )),
                    title: Text(
                      'Document verification',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
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
                    leading:
                        const ImageIcon(AssetImage('assets/icons/logout.png')),
                    title: const Text('Logout'),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
// 
