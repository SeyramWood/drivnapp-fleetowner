import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/shared/errors/failure.dart';

import '../../../../../shared/utils/usecase.dart';
import '../repositories/user.repo.dart';

class SubmitId implements UseCase<List<File>, MultiParams<List<File>,String,void>> {
  UserRepo repo;
  SubmitId({required this.repo});

  @override
  Future<Either<Failure, List<File>>> call(MultiParams<List<File>,String,void> params) async {
    return await repo.submitDocs(params.data1,params.data2);
  }
}
