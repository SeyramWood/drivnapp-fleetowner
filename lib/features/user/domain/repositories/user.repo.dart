import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/features/user/domain/entities/user.signup.model.dart';

import '../../../../shared/errors/failure.dart';
import '../entities/driver.profile.model.dart';
import '../entities/owner.profile.model.dart';
import '../../domain/entities/driver.profile.model.dart' as driver;

abstract class UserRepo {
  Future<Either<Failure, void>> create(
      SignUpBody fleetOwner, String accountType);
  Future<Either<Failure, String>> login(String phoneNumber, String password);
  Future<Either<Failure, String>> refreshAccessToken(String token);
  Future<Either<Failure, Profile>> fetchOwnerProfile(String iD);
  Future<Either<Failure, DProfile>> fetchDriverProfile(String iD);
  Future<Either<Failure, String>> updateUser(
      String id, String requestBody, String accountType);
  Future<Either<Failure, String>> verify(String otp, String accountType);
  Future<Either<Failure, String>> submitDocs(List<File> file, String userID);
  Future<Either<Failure, List<File>>> submitId(List<File> file, String userID);
  Future<Either<Failure, String>> submitData(
      String userID, driver.Document docs);
  Future<Either<Failure, String>> updateProfilePic(File file);
  Future<Either<Failure, String>> logOut();
}
