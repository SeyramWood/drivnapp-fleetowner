// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn_app/features/user/data/api/fleet.owner.api.dart';
import 'package:drivn_app/shared/errors/failure.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/utils/usecase.dart';
import '../../../data/repositories/fleet.owner.repo.impl.dart';
import '../../entities/fleetOwner.model.dart';
import '../../repositories/fleet.owner.repo.dart';

class PostUseCase extends ChangeNotifier
    implements UseCase<FleetOwner, Params<FleetOwner>> {
  final FleetOwnerRepo repo;
  PostUseCase(this.repo);
  PostUseCase.empty() : repo = FleetOwnerRepoImpl.empty();

  @override
  Future<Either<FleetOwner, Failure>> call(Params<FleetOwner> params) async {
    return await repo.create(params.data);
  }
}
