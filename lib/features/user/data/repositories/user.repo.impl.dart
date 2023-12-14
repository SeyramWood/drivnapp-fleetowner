import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/features/user/domain/entities/user.signup.model.dart';
import 'package:drivn/shared/errors/failure.dart';

import '../../../../shared/errors/exception.dart';
import '../../domain/entities/driver.profile.model.dart';
import '../../domain/entities/owner.profile.model.dart';
import '../../domain/repositories/user.repo.dart';
import '../api/user.api.service.dart';
import '../../domain/entities/driver.profile.model.dart' as driver;

class UserRepoImpl implements UserRepo {
  UserApiService api;

  UserRepoImpl(this.api);

  @override
  Future<Either<Failure, void>> create(
      SignUpBody fleetOwner, String accountType) async {
    try {
      await api.postUser(fleetOwner, accountType);
      return const Right<Failure, void>(null);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure('Unkown error'));
    }
  }

  @override
  Future<Either<Failure, String>> updateUser(
      String id, String requestBody, String accountType) async {
    try {
      await api.updateUser(id, requestBody, accountType);
      return Right(id);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verify(String otp, String accountType) async {
    try {
      final result = await api.verifyUser(otp, accountType);
      return Right(result);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure('$e'));
    }
  }

  @override
  Future<Either<Failure, String>> submitDocs(
      List<File> file, String userID) async {
    try {
      final result = await api.submitDoc(file, userID);

      return Right(result);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Profile>> fetchOwnerProfile(String iD) async {
    try {
      final result = await api.fetchOwnerProfile(iD);
      return Right(result);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DProfile>> fetchDriverProfile(String iD) async {
    try {
      final result = await api.fetchDriverProfile(iD);
      return Right(result);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> submitId(
      List<File> file, String userID) async {
    try {
      await api.submitId(file, userID);
      return Right("Identity files submitted successfully");
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> login(
      String phoneNumber, String password) async {
    try {
      final result = await api.logIn(phoneNumber, password);
      return Right(result);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> submitData(
      String userID, driver.Document docs) async {
    try {
      final result = await api.submitData(userID, docs);
      return Right(result);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> refreshAccessToken(String token) async {
    try {
      final result = await api.refreshAccessToken(token);
      return Right(result);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure('$e'));
    }
  }

  @override
  Future<Either<Failure, String>> updateProfilePic(File file) async {
    try {
      final result = await api.updateProfilePic(file);
      return Right(result);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure('$e'));
    }
  }

  @override
  Future<Either<Failure, String>> logOut() async {
    try {
      await api.logOut();
      return const Right('Logged out');
    } catch (e) {
      return Left(Failure('$e'));
    }
  }
}
