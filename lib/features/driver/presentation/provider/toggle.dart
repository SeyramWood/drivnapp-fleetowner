import 'package:flutter/material.dart';

import '../../../../shared/utils/shared.prefs.manager.dart';

class Toggled extends ValueNotifier<bool> {
  Toggled._sharedInference() : super(true);
  static final Toggled _shared = Toggled._sharedInference();
  factory Toggled() => _shared;
  bool get clicked => value;
  void isClicked(bool clicked) {
    value = clicked;
    notifyListeners();
  }
}

class GoOnline extends ValueNotifier<bool> {
  GoOnline._go() : super(false);

  static final GoOnline _goOnline = GoOnline._go();

  factory GoOnline() => _goOnline;

  bool get isOnline => value;

  Future<void> init() async {
    // Initialize status from SharedPreferences
    var status =  SharedPreferencesManager.instance.getString('isOnline', '');

    // Set the initial value based on SharedPreferences
    value = status == 'online';

    notifyListeners();
  }

  void goOnline(bool isOnline) async {
    // Update the value in SharedPreferences
    await SharedPreferencesManager.instance.setString('isOnline', isOnline ? 'online' : 'offline');

    // Update the value locally and notify listeners
    value = isOnline;
    notifyListeners();
  }
}

