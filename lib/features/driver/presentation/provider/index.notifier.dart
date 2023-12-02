import 'package:flutter/material.dart';
//this class toggles the index changes in the main page
class IndexNotifier extends ValueNotifier<int> {
  IndexNotifier.empty() : super(0);
  static final IndexNotifier _empty = IndexNotifier.empty();
  factory IndexNotifier() => _empty;

  setValue(newValue) {
    value = newValue;
    notifyListeners();
  }
}