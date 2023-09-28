import 'package:dartz/dartz.dart';
import 'package:drivn/shared/errors/failure.dart';

import '../../../../../shared/utils/usecase.dart';
import '../repositories/user.repo.dart';

class VerifyUser 
    implements UseCase<String, Params<String>> {
  final UserRepo repo;
  VerifyUser(this.repo);

  @override
  Future<Either<Failure, String>> call(Params<String> params) async {
    return await repo.verify(params.data);
  }
}
