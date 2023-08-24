// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/shared/errors/failure.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/utils/usecase.dart';
import '../../../data/repositories/fleet.owner.repo.impl.dart';
import '../../entities/user.signup.model.dart';
import '../../repositories/fleet.owner.repo.dart';

class PostUseCase extends ChangeNotifier
    implements UseCase<void, Params<SignUpBody>> {
  final UserRepo repo;
  PostUseCase(this.repo);
  PostUseCase.empty() : repo = FleetOwnerRepoImpl.empty();

  @override
  Future<Either<Failure, void>> call(Params<SignUpBody> params) async {
    return await repo.create(params.data);
  }
}
