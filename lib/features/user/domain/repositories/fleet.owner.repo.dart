import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/features/user/domain/entities/user.signup.model.dart';

import '../../../../shared/errors/failure.dart';

abstract class UserRepo {
  Future<Either<Failure, void>> create(SignUpBody fleetOwner);
  Future<Either<Failure, SignUpBody>> read(SignUpBody fleetOwner);
  Future<Either<Failure, SignUpBody>> update(SignUpBody fleetOwner);
  Future<Either<Failure, String>> verify(String otp);
  Future<Either<Failure, List<File>>> submitID(
      List<File> file);
}
