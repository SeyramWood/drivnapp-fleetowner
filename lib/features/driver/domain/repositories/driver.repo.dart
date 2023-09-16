import 'package:dartz/dartz.dart';
import 'package:drivn/features/driver/domain/entities/trips.model.dart';
import 'package:drivn/shared/errors/failure.dart';

import '../entities/request.model.dart';

abstract class DriverRepo{
  Future<Either<Failure,List<DRequest>>> fetchRequest(String userID);
  Future<Either<Failure,void>> acceptRequest(String requestID);
  Future<Either<Failure,void>> cancelRequest(String requestID,String reason);
  Future<Either<Failure,List<DTrip>>> fetchTrips(String userID);
  Future<Either<Failure,void>> goOnline(String userID,String status);
}