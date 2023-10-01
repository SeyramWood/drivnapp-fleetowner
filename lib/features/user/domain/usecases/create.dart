// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/shared/errors/failure.dart';

import '../../../../../shared/utils/usecase.dart';
import '../entities/user.signup.model.dart';
import '../repositories/user.repo.dart';
class PostUseCase 
    implements UseCase<void, MultiParams<SignUpBody,String,void>> {
  final UserRepo repo;
  PostUseCase(this.repo);

  @override
  Future<Either<Failure, void>> call(MultiParams<SignUpBody,String,void> params) async {
    return await repo.create(params.data1,params.data2);
  }
}
