// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

import '../repositories/user.repo.dart';

class Login extends UseCase<dynamic, MultiParams<String, String, String>> {
  final UserRepo repo;
  Login({
    required this.repo,
  });

  @override
  Future<Either<Failure, dynamic>> call(
      MultiParams<String, String, String> params) async {
    return await repo.login(params.data1, params.data2,params.data3!);
  }
}
