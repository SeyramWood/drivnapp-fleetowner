import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/features/user/domain/entities/user.signup.model.dart';
import 'package:drivn/shared/errors/failure.dart';
import 'package:flutter/material.dart';

import '../../../../shared/errors/exception.dart';
import '../../domain/repositories/fleet.owner.repo.dart';
import '../api/api.service.dart';

class FleetOwnerRepoImpl implements UserRepo {
  APIService api;

  FleetOwnerRepoImpl(this.api);

  @override
  Future<Either<Failure, void>> create(SignUpBody fleetOwner) async {
    try {
      await api.postUser(fleetOwner);
      return const Right<Failure, void>(null);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } catch (e) {
      return Left(Failure('Unkown error'));
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
      await api.verifyUser(otp);
      return const Right('');
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } catch (e) {
      return Left(Failure('Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, List<File>>> submitID(
    List<File> file
  ) async {
    try {
      final result = await api.uploadFiles(
        file,
      );
      return Right(result);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
