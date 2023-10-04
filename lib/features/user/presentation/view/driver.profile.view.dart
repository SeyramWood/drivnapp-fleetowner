import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/features/auth/presentation/views/validating.view.dart';
import 'package:drivn/features/user/data/api/user.api.service.dart';
import 'package:drivn/features/user/domain/entities/driver.profile.model.dart';
import 'package:drivn/shared/errors/error.alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../../../shared/utils/extentions/on.custom.elevated.button.dart';
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
    final userId = context.read<UserAuthProvider>().userID;

    final data = UserApiService().fetchDriverProfile(userId);
    profileData = data;
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
                  var provider = context.read<UserAuthProvider>();
                  LoadingDialog.showLoadingDialog(context);
                  // Handle save button press and update profil4
                  final updatedFirstName = firstNameController.text;
                  final updatedLastName = lastNameController.text;
                  // Perform the update operation with the new data
                  await provider
                      .updateUser(
                    provider.userID,
                    '$updatedFirstName/$updatedLastName',
                    provider.accountType,
                  )
                      .then(
                    (failure) {
                      if (failure == null) {
                        setState(() {
                          getProfile();
                        });
                      }
                      LoadingDialog.hideLoadingDialog(context);
                      if (failure != null) {
                        return showErrorDialogue(context, failure);
                      }

                      Navigator.pop(context);
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Something went wrong'),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () => getProfile(),
                  )
                ],
              ),
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
              body: SingleChildScrollView(
                child: Column(
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
                    SizedBox(height: MediaQuery.sizeOf(context).height / 4),
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
          return const Center(child: CircularProgressIndicator());
        });
  }
}
// 
