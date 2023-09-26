// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/features/owner/data/api/owner.api.dart';
import 'package:drivn/features/owner/domain/entities/booked.vehicle.model.dart';
import 'package:drivn/features/owner/domain/entities/driver.model.dart';
import 'package:drivn/features/owner/domain/entities/update.rental.model.dart';
import 'package:drivn/features/owner/domain/entities/v.request.model.dart';
import 'package:drivn/features/owner/domain/entities/vehicle.model.dart'
    as model;
import 'package:drivn/features/owner/domain/repository/owner.repo.dart';
import 'package:drivn/shared/errors/exception.dart';
import 'package:drivn/shared/errors/failure.dart';

class OwnerRepoImpl implements OwnerRepo {
  OwnerApiService apiService;
  OwnerRepoImpl({
    required this.apiService,
  });
  @override
  Future<Either<Failure, void>> acceptRequest(String requestID) async {
    return await apiService.acceptRequest(requestID);
  }

  @override
  Future<Either<Failure, String?>> addVehicle(
      model.VehicleToDBModel vehicle) async {
    return await apiService.addVehicle(vehicle: vehicle);
  }

  @override
  Future<Either<Failure, void>> cancelRequest(
      String requestID, String? reason) async {
    return await apiService.cancelRequest(requestID, reason);
  }

  @override
  Future<Either<Failure, void>> deleteVehicle(String vehicleID) async {
    return await apiService.deleteVehicle(vehicleID);
  }

  @override
  Future<Either<Failure, List<BookedVehicle>>> fetchBookedVehicles(
      String userID) async {
    try {
      var result = await apiService.fetchBookedVehicles(userID);
      return Right(result);
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Failed to fetch vehicls'));
    }
  }

  @override
  Future<Either<Failure, List<Dryver>>> fetchDrivers() async {
   try {
      var result = await apiService.fetchDrivers();
      return Right(result);
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Failed to fetch drivers'));
    }
  }

  @override
  Future<Either<Failure, List<VRequest>>> fetchRequests(String userID) async {
    try {
      var result = await apiService.allRequests(userID);
      return Right(result);
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Failed to fetch request'));
    }
  }

  @override
  Future<Either<Failure, List<model.Vehicle>>> fetchVehicles(String userID) async {
    try {
      var result = await apiService.fetchVehicles(userID);
      return Right(result);
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Failed to fetch vehicles'));
    }
  }

  @override
  Future<Either<Failure, void>> updateAvailability(
      String vehicleID, String status) async {
    try {
      return await apiService.updateAvailability(vehicleID,status);
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Failed to update availability'));
    }
  }

  @override
  Future<Either<Failure, void>> updateRental(
      String vehicleID, UpdateRentalModel updateRentalModel) async {
    try {
     return await apiService.updateRental(vehicleID,updateRentalModel);
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Failed to update rental'));
    }
  }
}
