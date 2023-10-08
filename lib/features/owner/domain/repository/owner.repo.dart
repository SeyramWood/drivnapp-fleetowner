import 'package:dartz/dartz.dart';
import 'package:drivn/features/owner/domain/entities/booked.vehicle.model.dart';
import 'package:drivn/features/owner/domain/entities/driver.model.dart';
import 'package:drivn/features/owner/domain/entities/update.rental.model.dart';
import 'package:drivn/features/owner/domain/entities/vehicle.model.dart'
    as model;

import '../../../../shared/errors/failure.dart';
import '../entities/v.request.model.dart';

abstract class OwnerRepo {
  Future<Either<Failure, void>> addVehicle(model.VehicleToDBModel vehicle);
  Future<Either<Failure, List<model.Vehicle>>> fetchVehicles(String userID);
  Future<Either<Failure, List<BookedVehicle>>> fetchBookedVehicles(
      String userID);
  Future<Either<Failure, void>> updateRental(
      String vehicleID, UpdateRentalModel updateRentalModel);

  Future<Either<Failure, void>> updateAvailability(
      String vehicleID, String status);
  Future<Either<Failure, List<Dryver>>> fetchDrivers();
  Future<Either<Failure, List<VRequest>>> fetchRequests(String userID);

  Future<Either<Failure, void>> deleteVehicle(String vehicleID);

  Future<Either<Failure, void>> acceptRequest(String requestID);
  Future<Either<Failure, void>> cancelRequest(String requestID, String? reason);
  Future<Either<Failure, String>> addInsurance(String vehicleID);
}
