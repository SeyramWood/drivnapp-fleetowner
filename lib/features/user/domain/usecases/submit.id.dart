import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/shared/errors/failure.dart';

import '../../../../../shared/utils/usecase.dart';
import '../repositories/user.repo.dart';

class SubmitId implements UseCase<String, MultiParams<List<File>,String,void>> {
  UserRepo repo;
  SubmitId({required this.repo});

  @override
  Future<Either<Failure, String>> call(MultiParams<List<File>,String,void> params) async {
    return await repo.submitId(params.data1,params.data2);
  }
}
