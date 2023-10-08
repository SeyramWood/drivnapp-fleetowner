import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../features/auth/presentation/widget/elevated.button.dart';

extension CustomExtention on CustomElevatedButton {
  loading(bool isLoading) {
    return isLoading
        ? const CustomElevatedButton(
            onPressed: null,
            child: SizedBox.square(
              dimension: 20,
              // child: CircularProgressIndicator.adaptive(
              //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              // ),
            ))
        : this;
  }
}

class LoadingDialog {
  static void showLoadingDialog(BuildContext context) {
    {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
              backgroundColor: Colors.white.withOpacity(0.0),
              elevation: 0.0,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.inkDrop(color: yellow, size: 60),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      "PLEASE WAIT...",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
