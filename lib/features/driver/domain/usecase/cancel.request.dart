import 'package:dartz/dartz.dart';
import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

import '../repositories/driver.repo.dart';

class CancelRequest extends UseCase<void,MultiParams<String,String>>{
  final DriverRepo repo;

  CancelRequest(this.repo);

  @override
  Future<Either<Failure, void>> call(MultiParams<String,String> params) async {
    return await repo.cancelRequest(params.data,params.data2);
  }
  

}