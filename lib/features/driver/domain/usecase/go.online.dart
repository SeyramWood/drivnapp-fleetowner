import 'package:dartz/dartz.dart';
import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

import '../repositories/driver.repo.dart';

class GoOnline extends UseCase<void,MultiParams<String,String>>{
    final DriverRepo repo;

  GoOnline(this.repo);

  @override
  Future<Either<Failure, void>> call(MultiParams<String,String> params) async {
    return await repo.goOnline(params.data,params.data2);
  }

}