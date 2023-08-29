import 'package:flutter/material.dart';

class AvailabelOrBooked extends ValueNotifier<bool> {
  AvailabelOrBooked._sharedInference() : super(true);
  static final AvailabelOrBooked _shared = AvailabelOrBooked._sharedInference();
  factory AvailabelOrBooked() => _shared;
  bool get clicked => value;
  void isClicked(bool clicked) {
    value = clicked;
    notifyListeners();
  }
}
