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
    try {
      await apiService.acceptRequest(requestID);
      return const Right(null);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } catch (e) {
      return Left(Failure('Failed to execute: Something went wrong.'));
    }
  }

  @override
  Future<Either<Failure, String>> addVehicle(
      model.VehicleToDBModel vehicle) async {
    try {
      await apiService.addVehicle(vehicle: vehicle);
      return const Right('Vehicle added successfully');
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } catch (e) {
      return Left(Failure('Failed to execute: Something went wrong.'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelRequest(
      String requestID, String? reason) async {
    try {
      await apiService.cancelRequest(requestID, reason);
      return const Right(null);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } catch (e) {
      return Left(Failure('Failed to execute: Something went wrong.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteVehicle(String vehicleID) async {
    try {
      await apiService.deleteVehicle(vehicleID);
      return const Right(null);
    } on CustomException catch (error) {
      return Left(Failure(error.message));
    } catch (e) {
      return Left(Failure('Failed to execute: Something went wrong.'));
    }
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
  Future<Either<Failure, List<model.Vehicle>>> fetchVehicles(
      String userID) async {
    try {
      var result = await apiService.fetchVehicles(userID);
      return Right(result);
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Something went wrong.'));
    }
  }

  @override
  Future<Either<Failure, void>> updateAvailability(
      String vehicleID, String status) async {
    try {
      await apiService.updateAvailability(vehicleID, status);
      return const Right(null);
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Something went wrong.'));
    }
  }

  @override
  Future<Either<Failure, void>> updateRental(
      String vehicleID, UpdateRentalModel updateRentalModel) async {
    try {
      await apiService.updateRental(vehicleID, updateRentalModel);
      return const Right(null);
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Something went wrong.'));
    }
  }

  @override
  Future<Either<Failure, String>> addInsurance(String vehicleID) async {
    try {
      await apiService.addInsurance(vehicleID);
      return const Right('Insurance added successfully');
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Something went wrong.'));
    }
  }

  @override
  Future<Either<Failure, String>> addVehicleDocument(String vehicleID) async {
    try {
      await apiService.addVehicleDocument(vehicleID);
      return const Right('Document added successfully');
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Something went wrong.'));
    }
  }

  @override
  Future<Either<Failure, String>> addVehicleImage(String vehicleID) async {
    try {
      await apiService.addVehicleImage(vehicleID);
      return const Right('Image(s) added successfully');
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Something went wrong.'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteVehicleDocument(String documentID) async {
    try {
      await apiService.deleteVehicleDocument(documentID);
      return const Right('Document deleted successfully');
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Something went wrong.'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteVehicleImage(String imageID) async {
    try {
      await apiService.deleteVehicleImage(imageID);
      return const Right('Image deleted successfully');
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Something went wrong.'));
    }
  }

  @override
  Future<Either<Failure, String>> updateVehicleDocument(String documentID) async {
    try {
      await apiService.addVehicleDocument(documentID);
      return const Right('Document updated successfully');
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Something went wron.'));
    }
  }

  @override
  Future<Either<Failure, String>> updateVehicleImage(String imageID) async {
    try {
      await apiService.updateVehicleImage(imageID);
      return const Right('Image updated successfully');
    } on CustomException catch (failure) {
      return Left(Failure(failure.message));
    } catch (e) {
      return Left(Failure('Something went wrong.'));
    }
  }
}
