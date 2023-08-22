import 'package:dartz/dartz.dart';
import 'package:drivn_app/features/user/domain/entities/fleetOwner.model.dart';
import 'package:flutter/material.dart';

import '../../../../shared/errors/failure.dart';

abstract class FleetOwnerRepo extends ChangeNotifier{
   Future<Either<FleetOwner,Failure>> create(FleetOwner fleetOwner);
   Future<Either<FleetOwner,Failure>> read(FleetOwner fleetOwner);
   Future<Either<FleetOwner,Failure>> update(FleetOwner fleetOwner);
   Future<Either<String,Failure>> verify(String fleetOwner);
}
