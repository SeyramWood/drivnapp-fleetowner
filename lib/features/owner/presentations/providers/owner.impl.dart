import 'package:dartz/dartz.dart';
import 'package:drivn/features/owner/domain/entities/update.rental.model.dart';
import 'package:drivn/features/owner/domain/entities/vehicle.model.dart';
import 'package:drivn/features/owner/domain/usecase/add.insurance.dart';
import 'package:drivn/shared/utils/usecase.dart';
import 'package:flutter/material.dart';

import '../../../../shared/show.snacbar.dart';
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
  final AddInsurance _addInsurance;

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
    required AddInsurance addInsurance,
  })  : _acceptRequest = acceptRequest,
        _addVehicle = addVehicle,
        _cancelRequest = cancelRequest,
        _deleteVehicle = deleteVehicle,
        _fetchBookedVehicles = fetchBookedVehicles,
        _fetchDrivers = fetchDrivers,
        _fetchRequests = fetchRequests,
        _fetchVehicles = fetchVehicles,
        _updateAvailability = updateAvailability,
        _updateRental = updateRental,_addInsurance =addInsurance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future acceptRequest(String userID) async {
    final result = await _acceptRequest(Params(userID));
    return result.fold(
      (failure) => failure.message,
      (success) => success,
    );
  }

  Future addVehicle(VehicleToDBModel vehicle, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    final result = await _addVehicle(Params(vehicle));
    return result.fold(
      (failure) {
        _isLoading = false;
        notifyListeners();
        return failure.message;
      },
      (success) {
        _isLoading = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Vehicle added successfully'),
        ));
      },
    );
  }

  Future cancelRequest(String requestID, String? reason) async {
    final result = await _cancelRequest(MultiParams(requestID, reason ?? ''));
    return result.fold(
      (failure) => failure.message,
      (success) {},
    );
  }

  Future deleteVehicle(String vehicleID) async {
    final result = await _deleteVehicle(Params(vehicleID));
    return result.fold(
      (failure) => failure.message,
      (success) {},
    );
  }

  Future fetchBookedVehicles(String userID) async {
    final result = await _fetchBookedVehicles(Params(userID));
    return result.fold(
      (failure) => failure.message,
      (success) => success,
    );
  }

  Future fetchDrivers() async {
    final result = await _fetchDrivers(Params(NoParams));
    return result.fold(
      (failure) => failure.message,
      (success) => success,
    );
  }

  Future fetchRequests(String userID) async {
    final result = await _fetchRequests(Params(userID));
    return result.fold(
      (failure) => failure.message,
      (success) => success,
    );
  }

  Future<Either<String,List<Vehicle>?>> fetchVehicles(String userID, context) async {
    final result = await _fetchVehicles(Params(userID));
    return result.fold(
      (failure) {
       return Left(failure.message);
      },
      (success) {
       return Right(success);
      },
    );
  }

  Future<Either<String,String>> addInsurance(String vehicleID)async{
final result = await _addInsurance(Params(vehicleID));
return result.fold((failure){
  return Left(failure.message);
},(success){return Right(success);});
  } 

  Future updateAvailability(String vehicleID, String status) async {
    final result = await _updateAvailability(MultiParams(vehicleID, status));
    return result.fold(
      (failure) => failure.message,
      (success) {
        return success;
      },
    );
  }

  Future updateRental(
      String vehicleID, UpdateRentalModel updateRentalModel) async {
    _isLoading = true;
    notifyListeners();
    final result =
        await _updateRental(MultiParams(vehicleID, updateRentalModel));
    return result.fold(
      (failure) {
        _isLoading = false;
        notifyListeners();
        return failure.message;
      },
      (success) {
        _isLoading = false;
        notifyListeners();
        return success;
      },
    );
  }
}
