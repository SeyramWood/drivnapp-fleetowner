// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/features/owner/domain/entities/update.rental.model.dart';
import 'package:drivn/shared/errors/failure.dart';

import '../../../../shared/utils/usecase.dart';
import '../repository/owner.repo.dart';

class UpdateRental
    extends UseCase<void, MultiParams<String, UpdateRentalModel>> {
  OwnerRepo repo;
  UpdateRental({
    required this.repo,
  });
  @override
  Future<Either<Failure, void>> call(
      MultiParams<String, UpdateRentalModel> params) async {
    return await repo.updateRental(
      params.data1,
      params.data2,
    );
  }
}
