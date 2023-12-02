import 'package:flutter/material.dart';

class CarProvider extends ChangeNotifier {
  //setting and getting date
  DateTime _date = DateTime.now();
  get date => _date;
  set setDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  //setting and getting time
  TimeOfDay _time = TimeOfDay.now();
  get time => _time;
  set setTime(TimeOfDay time) {
    _time = time;
    notifyListeners();
  }
}
