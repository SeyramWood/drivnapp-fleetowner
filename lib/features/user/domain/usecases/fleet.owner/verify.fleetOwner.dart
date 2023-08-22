import 'package:dartz/dartz.dart';
import 'package:drivn_app/shared/errors/failure.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/utils/usecase.dart';
import '../../../data/repositories/fleet.owner.repo.impl.dart';
import '../../entities/fleetOwner.model.dart';
import '../../repositories/fleet.owner.repo.dart';

class VerifyFleetOwner extends ChangeNotifier
    implements UseCase<String, Params<String>> {
  final FleetOwnerRepo repo;
  VerifyFleetOwner(this.repo);
  VerifyFleetOwner.empty() : repo = FleetOwnerRepoImpl.empty();

  @override
  Future<Either<String, Failure>> call(Params<String> params) async {
    return await repo.verify(params.data);
  }
}
