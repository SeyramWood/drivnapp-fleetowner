import 'dart:io';

import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/features/auth/presentation/views/validating.view.dart';
import 'package:drivn/features/user/domain/entities/driver.profile.model.dart';
import 'package:drivn/shared/errors/error.alert.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../shared/show.snacbar.dart';
import '../../../../shared/utils/cached.network.image.dart';
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
  Future<DProfile>? profile;

  @override
  void initState() {
    getProfile();

    super.initState();
  }

  Future<void> updateImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      var pickedImage0 = File(pickedImage.path);

      if (context.mounted) {
        await context
            .read<UserAuthProvider>()
            .updateProfilePicture(pickedImage0, context)
            .then(
              (value) => getProfile(),
            );
      }
    }
  }

  void getProfile() async {
    final userId = context.read<UserAuthProvider>().userID;
    final result =
        await context.read<UserAuthProvider>().fetchDriverProfile(userId);
    result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
          ),
        );
      },
      (profile) {
        setState(() {
          this.profile = Future.value(profile);
        });
      },
    );
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
        future: profile,
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

                      showEditProfileDialog(snapshot.data!);
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
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                            radius: 35,
                            child: profile.avatar != null
                                ? showImage(
                                    imageUrl: profile.avatar!,
                                    radius: 50,
                                  )
                                : // Display the picked image
                                {
                                    Text(
                                      '${profile.firstName[0]} ${profile.lastName[0]}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: black,
                                      ),
                                    )
                                  }),
                        Positioned(
                          right: -10, // Adjust the position as needed
                          bottom: -15, // Adjust the position as needed
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              color: black,
                            ),
                            onPressed:
                                updateImage, // Allow users to pick an image
                          ),
                        ),
                      ],
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
                    SizedBox(height: MediaQuery.sizeOf(context).height),
                    ListTile(
                      onTap: () async {
                        LoadingDialog.showLoadingDialog(context);
                        await context.read<UserAuthProvider>().logOut().then(
                          (value) {
                            value.fold((failure) {
                              LoadingDialog.hideLoadingDialog(context);
                              showCustomSnackBar(context, failure,red);
                            }, (success) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                                (route) => false,
                              );
                              showCustomSnackBar(context, success,Colors.green);
                            });
                          },
                        );
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
