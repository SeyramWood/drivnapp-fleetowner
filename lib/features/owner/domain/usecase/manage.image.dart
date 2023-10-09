// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/shared/errors/failure.dart';

import '../../../../shared/utils/usecase.dart';
import '../repository/owner.repo.dart';

class AddVehicleImage extends UseCase<String, Param<String>> {
  OwnerRepo repo;
  AddVehicleImage({
    required this.repo,
  });
  @override
  Future<Either<Failure, String>> call(params) async {
    return await repo.addVehicleImage(params.data);
  }
}

class UpdateVehicleImage extends UseCase<String, Param<String>> {
  OwnerRepo repo;
  UpdateVehicleImage({
    required this.repo,
  });
  @override
  Future<Either<Failure, String>> call(params) async {
    return await repo.updateVehicleImage(params.data);
  }
}

class DeleteVehicleImage extends UseCase<String, Param<String>> {
  OwnerRepo repo;
  DeleteVehicleImage({
    required this.repo,
  });
  @override
  Future<Either<Failure, String>> call(params) async {
    return await repo.deleteVehicleImage(params.data);
  }
}
