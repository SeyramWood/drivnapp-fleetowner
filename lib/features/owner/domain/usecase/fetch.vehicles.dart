// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/features/owner/domain/entities/vehicle.model.dart';
import 'package:drivn/shared/errors/failure.dart';

import '../../../../shared/utils/usecase.dart';
import '../repository/owner.repo.dart';

class FetchVehicles extends UseCase<List<Vehicle>, Params<String>> {
  OwnerRepo repo;
  FetchVehicles({
    required this.repo,
  });
  @override
  Future<Either<Failure, List<Vehicle>>> call(Params<String> params) async {
    return await repo.fetchVehicles(params.data);
  }
}
