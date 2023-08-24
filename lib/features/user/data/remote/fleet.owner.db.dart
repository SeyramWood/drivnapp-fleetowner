// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:drivn/features/user/domain/entities/user.signup.model.dart';
import 'package:http/http.dart';

import '../api/fleet.owner.api.dart';

abstract class UserDB extends ChangeNotifier {
  Future<void> create(SignUpBody fleetOwner);
  Future<SignUpBody> read(SignUpBody fleetOwner);
  Future<SignUpBody> update(SignUpBody fleetOwner);
  Future<String> verify(String otp);
  Future<List<MultipartFile>> submitID(List<MultipartFile> file);
}

class UserDBImpl extends ChangeNotifier implements UserDB {
  APIService api;
  UserDBImpl(this.api);
  UserDBImpl.empty() : api = APIService();
  @override
  Future<void> create(SignUpBody user) async {
    return await api.postUser(user);
  }

  @override
  Future<SignUpBody> read(SignUpBody fleetOwner) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<SignUpBody> update(SignUpBody fleetOwner) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<String> verify(String otp) async {
    return await api.verifyFleetOwner(otp);
  }

  @override
  Future<List<MultipartFile>> submitID(List<MultipartFile> file) async {
    return await api.submitIDs(file);
  }
}
