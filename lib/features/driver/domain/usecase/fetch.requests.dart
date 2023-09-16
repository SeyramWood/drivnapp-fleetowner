import 'package:dartz/dartz.dart';
import 'package:drivn/features/driver/domain/repositories/driver.repo.dart';
import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

import '../entities/request.model.dart';

class FetchRequest extends UseCase<List<DRequest>,Params<String>>{
  final DriverRepo repo;

  FetchRequest(this.repo);
  @override
  Future<Either<Failure, List<DRequest>>> call(Params params) async {
    return await repo.fetchRequest(params.data);
  }
}