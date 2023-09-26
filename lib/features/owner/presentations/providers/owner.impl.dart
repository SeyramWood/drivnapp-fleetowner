import 'package:drivn/features/owner/domain/entities/update.rental.model.dart';
import 'package:drivn/features/owner/domain/entities/vehicle.model.dart';
import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';

import 'package:drivn/shared/utils/usecase.dart';

import '../../domain/usecase/accept.request.dart';
import '../../domain/usecase/add.vehicle.dart';
import '../../domain/usecase/cancel.request.dart';
import '../../domain/usecase/delete.vehicle.dart';
import '../../domain/usecase/fetch.booked.vehicles.dart';
import '../../domain/usecase/fetch.driver.dart';
import '../../domain/usecase/fetch.requests.dart';
import '../../domain/usecase/fetch.vehicles.dart';
import '../../domain/usecase/update.availability.dart';
import '../../domain/usecase/update.rental.dart';

class OwnerImplProvider extends ChangeNotifier {
  final AcceptRequest _acceptRequest;
  final AddVehicle _addVehicle;
  final CancelRequest _cancelRequest;
  final DeleteVehicle _deleteVehicle;
  final FetchBookedVehicles _fetchBookedVehicles;
  final FetchDrivers _fetchDrivers;
  final FetchRequests _fetchRequests;
  final FetchVehicles _fetchVehicles;
  final UpdateAvailability _updateAvailability;
  final UpdateRental _updateRental;

  OwnerImplProvider({
    required AcceptRequest acceptRequest,
    required AddVehicle addVehicle,
    required CancelRequest cancelRequest,
    required DeleteVehicle deleteVehicle,
    required FetchBookedVehicles fetchBookedVehicles,
    required FetchDrivers fetchDrivers,
    required FetchRequests fetchRequests,
    required FetchVehicles fetchVehicles,
    required UpdateAvailability updateAvailability,
    required UpdateRental updateRental,
  })  : _acceptRequest = acceptRequest,
        _addVehicle = addVehicle,
        _cancelRequest = cancelRequest,
        _deleteVehicle = deleteVehicle,
        _fetchBookedVehicles = fetchBookedVehicles,
        _fetchDrivers = fetchDrivers,
        _fetchRequests = fetchRequests,
        _fetchVehicles = fetchVehicles,
        _updateAvailability = updateAvailability,
        _updateRental = updateRental;

  Future acceptRequest(String userID) async {
    try {
      final result = await _acceptRequest(Params(userID));
      return result.fold(
        (failure) => failure.message,
        (success) => success,
      );
    } catch (e) {
      return Left('Failed to accept request: $e');
    }
  }

  Future addVehicle(VehicleToDBModel vehicle) async {
    try {
      final result = await _addVehicle(Params(vehicle));
      return result.fold(
        (failure) => failure.message,
        (success) => success,
      );
    } catch (e) {
      return Left('Failed: $e');
    }
  }

  Future cancelRequest(String requestID, String? reason) async {
    try {
      final result = await _cancelRequest(MultiParams(requestID, reason ?? ''));
      return result.fold(
        (failure) => failure.message,
        (success) => success,
      );
    } catch (e) {
      return Left('Failed: $e');
    }
  }

  Future deleteVehicle(String vehicleID) async {
    try {
      final result = await _deleteVehicle(Params(vehicleID));
      return result.fold(
        (failure) => failure.message,
        (success) => success,
      );
    } catch (e) {
      return Left('Failed: $e');
    }
  }

  Future fetchBookedVehicles(String userID) async {
    try {
      final result = await _fetchBookedVehicles(Params(userID));
      return result.fold(
        (failure) => failure.message,
        (success) => success,
      );
    } catch (e) {
      return Left('Failed: $e');
    }
  }

  Future fetchDrivers() async {
    try {
      final result = await _fetchDrivers(Params(NoParams));
      return result.fold(
        (failure) => failure.message,
        (success) => success,
      );
    } catch (e) {
      return Left('Failed: $e');
    }
  }

  Future fetchRequests(String userID) async {
    try {
      final result = await _fetchRequests(Params(userID));
      return result.fold(
        (failure) => failure.message,
        (success) => success,
      );
    } catch (e) {
      return Left('Failed: $e');
    }
  }

  Future fetchVehicles(String userID) async {
    try {
      final result = await _fetchVehicles(Params(userID));
      return result.fold(
        (failure) => failure.message,
        (success) => success,
      );
    } catch (e) {
      return Left('Failed: $e');
    }
  }

  Future updateAvailability(String vehicleID, String status) async {
    try {
      final result = await _updateAvailability(MultiParams(vehicleID,status));
      return result.fold(
        (failure) => failure.message,
        (success) => success,
      );
    } catch (e) {
      return Left('Failed: $e');
    }
  }

  Future updateRental(String vehicleID,UpdateRentalModel updateRentalModel)async{
    try {
      final result = await _updateRental(MultiParams(vehicleID,updateRentalModel));
      return result.fold(
        (failure) => failure.message,
        (success) => success,
      );
    } catch (e) {
      return Left('Failed: $e');
    }
  }
}
