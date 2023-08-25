import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/shared/errors/failure.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../../shared/utils/usecase.dart';
import '../../../data/repositories/fleet.owner.repo.impl.dart';
import '../../repositories/fleet.owner.repo.dart';

class SubmitID extends ChangeNotifier
    implements UseCase<List<File>, Params<List<File>>> {
  final UserRepo repo;
  SubmitID(this.repo);
  SubmitID.empty() : repo = FleetOwnerRepoImpl.empty();

  @override
  Future<Either<Failure, List<File>>> call(
      Params<List<File>> params) async {
    return await repo.submitID(params.data);
  }
}
