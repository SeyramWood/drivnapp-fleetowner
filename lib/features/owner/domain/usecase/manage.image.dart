// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:drivn/shared/errors/failure.dart';

import '../../../../shared/utils/usecase.dart';
import '../repository/owner.repo.dart';

class AddVehicleImage extends UseCase<String, MultiParams<String,List<File>,String>> {
  OwnerRepo repo;
  AddVehicleImage({
    required this.repo,
  });
  @override
  Future<Either<Failure, String>> call(params) async {
    return await repo.addVehicleImage(params.data1,params.data2);
  }
}

class UpdateVehicleImage extends UseCase<String, MultiParams<String,File,String>> {
  OwnerRepo repo;
  UpdateVehicleImage({
    required this.repo,
  });
  @override
  Future<Either<Failure, String>> call(params) async {
    return await repo.updateVehicleImage(params.data1,params.data2);
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
