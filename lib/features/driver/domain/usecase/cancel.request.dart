import 'package:dartz/dartz.dart';
import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

import '../repositories/driver.repo.dart';

class CancelRequest extends UseCase<void,MultiParams<String,String,void>>{
   DriverRepo repo;

  CancelRequest(this.repo);

  @override
  Future<Either<Failure, void>> call(MultiParams<String,String,void> params) async {
    return await repo.cancelRequest(params.data1,params.data2);
  }
  

}