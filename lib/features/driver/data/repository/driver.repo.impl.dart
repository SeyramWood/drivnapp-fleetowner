import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/features/driver/data/api/driver.api.service.dart';
import 'package:drivn/features/driver/domain/entities/trips.model.dart';
import 'package:drivn/shared/errors/failure.dart';

import '../../../../shared/errors/exception.dart';
import '../../domain/entities/request.model.dart';
import '../../domain/repositories/driver.repo.dart';

class DriverRepoImpl implements DriverRepo {
  final DriverApiService _dataSource;

  DriverRepoImpl(this._dataSource);

  @override
  Future<Either<Failure, List<DRequest>>> fetchRequest(String userID) async {
    try {
      final result = await _dataSource.fetchRequest(userID);
      return Right(result);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure('Failed to fetch requests.'));
    }
  }

  @override
  Future<Either<Failure, void>> acceptRequest(String requestID) async {
    try {
      await _dataSource.acceptRequest(requestID);
      return const Right(null);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure('Failed to accept request. Try again.'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelRequest(
      String requestID, String reason) async {
    try {
      await _dataSource.cancelRequest(requestID, reason);
      return const Right(null);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure('Failed to cancel request. Try again.'));
    }
  }

  @override
  Future<Either<Failure, List<DTrip>>> fetchTrips(String userID) async {
    try {
      final result = await _dataSource.fetchTrips(userID);
      return Right(result);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure('Failed to fetch trips.'));
    }
  }

  @override
  Future<Either<Failure, void>> goOnline(String userID, String status) async {
    try {
      await _dataSource.goOnline(userID, status);
      return const Right(null);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } on SocketException catch (se) {
      return Left(Failure(
          se.message == "Failed host lookup: 'devapi.drivnapp.net'"
              ? "You are offline. Connect and retry"
              : se.message));
    } catch (e) {
      return Left(Failure('Failed to go online. Try again.'));
    }
  }
}
