import 'package:dartz/dartz.dart';
import 'package:drivn_app/shared/errors/failure.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/utils/usecase.dart';
import '../../../data/repositories/fleet.owner.repo.impl.dart';
import '../../entities/user.signup.model.dart';
import '../../repositories/fleet.owner.repo.dart';

class VerifyUser extends ChangeNotifier
    implements UseCase<String, Params<String>> {
  final UserRepo repo;
  VerifyUser(this.repo);
  VerifyUser.empty() : repo = FleetOwnerRepoImpl.empty();

  @override
  Future<Either<Failure, String>> call(Params<String> params) async {
    return await repo.verify(params.data);
  }
}
