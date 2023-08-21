import 'package:dartz/dartz.dart';
import 'package:drivn_app/shared/errors/failure.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/utils/usecase.dart';
import '../../../data/repositories/fleet.owner.repo.impl.dart';
import '../../entities/user.model.dart';
import '../../repositories/fleet.owner.repo.dart';

class UpdateUseCase extends ChangeNotifier implements UseCase<FleetOwner,Params>{
  final FleetOwnerRepo repo;

  UpdateUseCase.empty():repo = FleetOwnerRepoImpl.empty();

  @override
  Future<Either<Failure, FleetOwner>> call(Params params) {
    // TODO: implement call
    throw UnimplementedError();
  }

}