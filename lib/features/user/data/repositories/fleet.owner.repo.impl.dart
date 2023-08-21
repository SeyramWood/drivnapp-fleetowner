import 'package:dartz/dartz.dart';
import 'package:drivn_app/features/user/domain/entities/user.model.dart';
import 'package:drivn_app/shared/errors/failure.dart';
import 'package:flutter/material.dart';

import '../../domain/repositories/fleet.owner.repo.dart';
import '../remote/fleet.owner.db.dart';

class FleetOwnerRepoImpl extends ChangeNotifier implements FleetOwnerRepo {
  final FleetOwnerDB db;

  FleetOwnerRepoImpl(this.db);
  FleetOwnerRepoImpl.empty() : db = FleetOwnerDBImpl();

  @override
  Future<Either<FleetOwner, Failure>> create(FleetOwner fleetOwner) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<List<FleetOwner>, Failure>> read(FleetOwner fleetOwner) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Either<FleetOwner, Failure>> update(FleetOwner fleetOwner) {
    // TODO: implement update
    throw UnimplementedError();
  }

  
}
