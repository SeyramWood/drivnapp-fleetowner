import 'package:drivn/features/auth/presentation/views/validating.view.dart';
import 'package:drivn/features/user/data/api/user.api.service.dart';
import 'package:drivn/features/user/domain/entities/driver.profile.model.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
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
  late Future<DProfile> profile;
  getProfile() {
    profile = context
        .read<UserApiService>()
        .fetchDriverProfile(context.read<UserApiService>().userId);
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DProfile>(
        future: profile,
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
