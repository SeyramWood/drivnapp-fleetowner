import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedProvider extends ChangeNotifier {
 
  String _phone = '';
  String get phone => _phone;
  set phoneNumber(String phone) {
    _phone = phone;
  }

}
