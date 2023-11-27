import 'package:dartz/dartz.dart';
import 'package:drivn/features/driver/domain/entities/trips.model.dart';
import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

import '../repositories/driver.repo.dart';

class FetchTrips extends UseCase<List<DTrip>, Param<String>> {
  final DriverRepo repo;

  FetchTrips(this.repo);

  @override
  Future<Either<Failure, List<DTrip>>> call(Param<String> params) async {
    return await repo.fetchTrips(params.data);
  }
}
