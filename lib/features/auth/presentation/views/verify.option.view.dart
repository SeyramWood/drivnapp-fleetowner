import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/features/auth/presentation/views/verifyDriver.view.dart';
import 'package:drivn/features/auth/presentation/views/verifyOwner/verify.user.view.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../driver/presentation/views/main.page.dart';
import '../../../owner/presentations/views/home.dart';

class VerifyOptionView extends StatefulWidget {
  const VerifyOptionView({super.key});

  @override
  State<VerifyOptionView> createState() => _VerifyOptionViewState();
}

class _VerifyOptionViewState extends State<VerifyOptionView> {
  
  @override
  Widget build(BuildContext context) {
    var isDriver = context.read<UserAuthProvider>().accountType;
    return Scaffold(
      backgroundColor: blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Get Verified",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 30, color: white),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) =>
                              isDriver=='fleet-owners' ? const OMainPage() : const DMainPage()),
                      (route) => false,
                    );
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(black)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Later"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                ElevatedButton(
                  onPressed: () {

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => isDriver=='fleet-owners' 
                            ? const GetVerifiedOption()
                            : const VerifyDriverView(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(white)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Now",
                      style: TextStyle(color: black),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
