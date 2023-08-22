import 'package:dartz/dartz.dart';
import 'package:drivn_app/features/user/domain/entities/fleetOwner.model.dart';
import 'package:drivn_app/shared/errors/failure.dart';
import 'package:flutter/material.dart';

import '../../domain/repositories/fleet.owner.repo.dart';
import '../remote/fleet.owner.db.dart';

class FleetOwnerRepoImpl extends ChangeNotifier implements FleetOwnerRepo {
  final FleetOwnerDB db;

  FleetOwnerRepoImpl(this.db);
  FleetOwnerRepoImpl.empty() : db = FleetOwnerDBImpl.empty();
  
  @override
  Future<Either<FleetOwner, Failure>> create(FleetOwner fleetOwner) async {
    try {
      final result = await db.create(fleetOwner);
      return Left(result);
    } catch (e) {
      return Right(Failure('Could not create'));
    }
  }
  
  @override
  Future<Either<FleetOwner, Failure>> read(FleetOwner fleetOwner) {
    // TODO: implement read
    throw UnimplementedError();
  }
  
  @override
  Future<Either<FleetOwner, Failure>> update(FleetOwner fleetOwner) {
    // TODO: implement update
    throw UnimplementedError();
  }
  
  @override
  Future<Either<String, Failure>> verify(String otp) async {
   try {
     final result = await db.verify(otp);
     return Left(result);
   } catch (e) {
     return Right(Failure('could not verify'));
   }
  }

  
 
}
