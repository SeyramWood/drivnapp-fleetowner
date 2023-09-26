// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/shared/errors/failure.dart';

import '../../../../../shared/utils/usecase.dart';
import '../entities/user.signup.model.dart';
import '../repositories/fleet.owner.repo.dart';
class PostUseCase 
    implements UseCase<void, Params<SignUpBody>> {
  final UserRepo repo;
  PostUseCase(this.repo);

  @override
  Future<Either<Failure, void>> call(Params<SignUpBody> params) async {
    return await repo.create(params.data);
  }
}
