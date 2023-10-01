import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/shared/errors/failure.dart';

import '../../../../../shared/utils/usecase.dart';
import '../repositories/user.repo.dart';

class SubmitDoc implements UseCase<List<File>, MultiParams<List<File>,String,void>> {
  final UserRepo repo;
  SubmitDoc(this.repo);

  @override
  Future<Either<Failure, List<File>>> call(MultiParams<List<File>,String,void> params) async {
    return await repo.submitDocs(params.data1,params.data2);
  }
}
