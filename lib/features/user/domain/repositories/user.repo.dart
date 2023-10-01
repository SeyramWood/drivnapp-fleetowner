import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/features/user/domain/entities/user.signup.model.dart';

import '../../../../shared/errors/failure.dart';
import '../entities/driver.profile.model.dart';
import '../entities/owner.profile.model.dart';

abstract class UserRepo {
  Future<Either<Failure, void>> create(SignUpBody fleetOwner,String accountType);
  Future<Either<Failure, String>> login(String username, String password,String accountType);
  Future<Either<Failure, Profile>> fetchOwnerProfile(String iD);
  Future<Either<Failure, DProfile>> fetchDriverProfile(String iD);
  Future<Either<Failure, SignUpBody>> update(SignUpBody fleetOwner);
  Future<Either<Failure, String>> verify(String otp,String accountType);
  Future<Either<Failure, List<File>>> submitDocs(List<File> file,String userID);
  Future<Either<Failure, List<File>>> submitId(List<File> file,String userID);
}
