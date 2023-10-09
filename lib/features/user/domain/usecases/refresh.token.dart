// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:drivn/features/user/domain/repositories/user.repo.dart';
import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

class RefreshToken extends UseCase<String, Param<String>> {
  UserRepo repo;
  RefreshToken({
    required this.repo,
  });
  @override
  Future<Either<Failure, String>> call(Param<String> params) async {
    return await repo.refreshAccessToken(params.data);
  }
}
