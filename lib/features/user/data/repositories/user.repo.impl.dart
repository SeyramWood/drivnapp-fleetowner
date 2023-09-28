import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/features/user/domain/entities/user.signup.model.dart';
import 'package:drivn/shared/errors/failure.dart';

import '../../../../shared/errors/exception.dart';
import '../../domain/entities/driver.profile.model.dart';
import '../../domain/entities/owner.profile.model.dart';
import '../../domain/repositories/user.repo.dart';
import '../api/user.api.service.dart';

class UserRepoImpl implements UserRepo {
  UserApiService api;

  UserRepoImpl(this.api);

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
      return Left(Failure('$e'));
    }
  }

  @override
  Future<Either<Failure, List<File>>> submitID(List<File> file) async {
    try {
      final result = await api.uploadFiles(
        file,
      );
      return Right(result);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> login(
      String username, String password) async {
    try {
      final result = await api.logIn(username, password);
      return Right(result);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Profile>> fetchOwnerProfile(String iD) async {
    try {
      final result =await api.fetchOwnerProfile(iD);
      return Right(result);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
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
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
