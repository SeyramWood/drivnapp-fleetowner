import 'package:dartz/dartz.dart';
import 'package:drivn_app/features/user/domain/entities/user.model.dart';

import '../../../../shared/errors/failure.dart';

abstract class FleetOwnerRepo {
   Future<Either<FleetOwner,Failure>> create(FleetOwner fleetOwner);
   Future<Either<List<FleetOwner>,Failure>> read(FleetOwner fleetOwner);
   Future<Either<FleetOwner,Failure>> update(FleetOwner fleetOwner);
}
