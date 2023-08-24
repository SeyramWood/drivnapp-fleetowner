
import 'package:dartz/dartz.dart';
import 'package:drivn_app/features/user/domain/entities/user.signup.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../shared/errors/failure.dart';

abstract class UserRepo extends ChangeNotifier {
  Future<Either<Failure, void>> create(SignUpBody fleetOwner);
  Future<Either<Failure, SignUpBody>> read(SignUpBody fleetOwner);
  Future<Either<Failure, SignUpBody>> update(SignUpBody fleetOwner);
  Future<Either<Failure, String>> verify(String otp);
  Future<Either<Failure, List<MultipartFile>>> submitID(List<MultipartFile> file);
}
