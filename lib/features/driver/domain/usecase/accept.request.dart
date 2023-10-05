import 'package:dartz/dartz.dart';
import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

import '../repositories/driver.repo.dart';

class AcceptRequest extends UseCase<void,Params<String>>{
  final DriverRepo repo;

  AcceptRequest(this.repo);

  @override
  Future<Either<Failure, void>> call(Params<String> params) async {
    return await repo.acceptRequest(params.data);
  }
  
}