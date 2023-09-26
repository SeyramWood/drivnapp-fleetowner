// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/features/owner/domain/entities/driver.model.dart';
import 'package:drivn/shared/errors/failure.dart';

import '../../../../shared/utils/usecase.dart';
import '../repository/owner.repo.dart';

class FetchDrivers extends UseCase<List<Dryver>,Params<NoParams>> {
  OwnerRepo repo;
  FetchDrivers({
    required this.repo,
  });
  @override
  Future<Either<Failure, List<Dryver>>> call(Params params) async {
   return await repo.fetchDrivers();
  }
}
