import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/features/user/domain/entities/user.signup.model.dart';
import 'package:drivn/shared/errors/failure.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../domain/repositories/fleet.owner.repo.dart';
import '../remote/fleet.owner.db.dart';
import 'package:http/http.dart' as http;

class FleetOwnerRepoImpl extends ChangeNotifier implements UserRepo {
  final UserDB db;

  FleetOwnerRepoImpl(this.db);
  FleetOwnerRepoImpl.empty() : db = UserDBImpl.empty();

  @override
  Future<Either<Failure, void>> create(SignUpBody fleetOwner) async {
    try {
      await db.create(fleetOwner);
      return const Right<Failure, void>(null);
    } catch (e) {
      return Left(Failure('error 1:$e'));
    }
  }

  @override
  Future<Either<Failure, SignUpBody>> read(SignUpBody fleetOwner) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, SignUpBody>> update(SignUpBody fleetOwner) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> verify(String otp) async {
    try {
      final result = await db.verify(otp);
      return Right(result);
    } catch (e) {
      return Left(Failure('error 1:$e'));
    }
  }

  @override
  Future<Either<Failure, List<File>>> submitID(
      List<File> file) async {
    try {
      final result = await db.submitID(file);
      print('got here');
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
