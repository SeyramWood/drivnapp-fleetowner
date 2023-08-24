import 'package:flutter/material.dart';

import '../../../features/auth/presentation/widget/elevated.button.dart';

extension CustomExtention on CustomElevatedButton {
  Widget loading(bool isLoading) {
    return isLoading
        ? const CustomElevatedButton(
            onPressed: null,
            child: SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ))
        : this;
  }
  copyWith(){
    
  } 
}

