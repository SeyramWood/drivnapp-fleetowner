import 'package:dartz/dartz.dart';

import '../../../../shared/errors/failure.dart';
import '../../../../shared/utils/usecase.dart';
import '../repository/owner.repo.dart';

class AddVehicleDocument extends UseCase<String, Param<String>> {
  OwnerRepo repo;
  AddVehicleDocument({
    required this.repo,
  });
  @override
  Future<Either<Failure, String>> call(params) async {
    return await repo.addVehicleDocument(params.data);
  }
}

class UpdateVehicleDocument extends UseCase<String, Param<String>> {
  OwnerRepo repo;
  UpdateVehicleDocument({
    required this.repo,
  });
  @override
  Future<Either<Failure, String>> call(params) async {
    return await repo.updateVehicleDocument(params.data);
  }
}

class DeleteVehicleDocument extends UseCase<String, Param<String>> {
  OwnerRepo repo;
  DeleteVehicleDocument({
    required this.repo,
  });
  @override
  Future<Either<Failure, String>> call(params) async {
    return await repo.deleteVehicleDocument(params.data);
  }
}
