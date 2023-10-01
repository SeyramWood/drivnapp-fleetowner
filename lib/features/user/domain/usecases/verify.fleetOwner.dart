import 'package:dartz/dartz.dart';
import 'package:drivn/shared/errors/failure.dart';

import '../../../../../shared/utils/usecase.dart';
import '../repositories/user.repo.dart';

class VerifyUser 
    implements UseCase<String, MultiParams<String,String,void>> {
  final UserRepo repo;
  VerifyUser(this.repo);

  @override
  Future<Either<Failure, String>> call(MultiParams<String,String,void> params) async {
    return await repo.verify(params.data1,params.data2);
  }
}
