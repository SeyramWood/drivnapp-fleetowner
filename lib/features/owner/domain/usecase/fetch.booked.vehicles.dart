import 'package:dartz/dartz.dart';
import 'package:drivn/features/owner/domain/entities/booked.vehicle.model.dart';

import '../../../../shared/errors/failure.dart';
import '../../../../shared/utils/usecase.dart';
import '../repository/owner.repo.dart';

class FetchBookedVehicles extends UseCase<List<BookedVehicle>, Params<String>> {
  OwnerRepo repo;
  FetchBookedVehicles({
    required this.repo,
  });
  @override
  Future<Either<Failure, List<BookedVehicle>>> call(Params<String> params) async {
    return await repo.fetchBookedVehicles(params.data);
  }
}