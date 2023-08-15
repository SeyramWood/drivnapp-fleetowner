import 'package:flutter/material.dart';

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