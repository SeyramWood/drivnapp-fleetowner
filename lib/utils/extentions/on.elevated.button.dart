import 'package:flutter/material.dart';

import '../../features/auth/presentation/widget/elevated.button.dart';

extension WhileWait on CustomElevatedButton {
  Widget loading(bool isLoading) {
    return isLoading
        ? CustomElevatedButton(
            onPressed: null,
            child: SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ))
        : this;
  }
}
