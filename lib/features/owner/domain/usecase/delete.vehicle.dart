// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

import '../repository/owner.repo.dart';

class DeleteVehicle extends UseCase<void, Param<String>> {
  OwnerRepo repo;
  DeleteVehicle({
    required this.repo,
  });

  @override
  Future<Either<Failure, void>> call(Param params) async {
    return await repo.deleteVehicle(params.data);
  }
}
