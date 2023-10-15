// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

import '../repositories/user.repo.dart';

class LogOut extends UseCase<String,NoParams> {
  UserRepo repo;
  LogOut({
    required this.repo,
  });
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
   return await repo.logOut();
  }

}
