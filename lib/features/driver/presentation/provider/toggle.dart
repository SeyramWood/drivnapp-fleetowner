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

class GoOnline extends ValueNotifier<bool> {
  GoOnline._go() : super(true);
  static final GoOnline _goOnline = GoOnline._go();
  factory GoOnline() => _goOnline;
  bool get isOnline => value;
  void goOnline(bool isonline) {
    value = isonline;
    notifyListeners();
  }
}
