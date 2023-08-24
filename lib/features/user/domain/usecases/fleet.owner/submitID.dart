import 'package:dartz/dartz.dart';
import 'package:drivn_app/shared/errors/failure.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../../shared/utils/usecase.dart';
import '../../../data/repositories/fleet.owner.repo.impl.dart';
import '../../repositories/fleet.owner.repo.dart';

class SubmitID extends ChangeNotifier
    implements UseCase<List<MultipartFile>, Params<List<MultipartFile>>> {
  final UserRepo repo;
  SubmitID(this.repo);
  SubmitID.empty() : repo = FleetOwnerRepoImpl.empty();

  @override
  Future<Either<Failure, List<MultipartFile>>> call(
      Params<List<MultipartFile>> params) async {
    return await repo.submitID(params.data);
  }
}
