import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/shared/errors/failure.dart';

import '../../../../../shared/utils/usecase.dart';
import '../repositories/user.repo.dart';

class SubmitDoc implements UseCase<List<File>, Params<List<File>>> {
  final UserRepo repo;
  SubmitDoc(this.repo);

  @override
  Future<Either<Failure, List<File>>> call(Params<List<File>> params) async {
    return await repo.submitDocs(params.data);
  }
}
