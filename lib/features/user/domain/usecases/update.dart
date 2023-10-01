// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

import '../repositories/user.repo.dart';

class UpdateUser extends UseCase<void,MultiParams<String,String,String>> {
UserRepo repo;
  UpdateUser({
    required this.repo,
  });

  @override
  Future<Either<Failure, void>> call(MultiParams<String, String, String> params) {
    // TODO: implement call
    throw UnimplementedError();
  }

}
