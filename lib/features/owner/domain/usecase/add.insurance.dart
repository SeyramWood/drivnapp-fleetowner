// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/features/owner/domain/repository/owner.repo.dart';
import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

class AddInsurance extends UseCase<String, Param<String>> {
  OwnerRepo repo;
  AddInsurance({
    required this.repo,
  });
  @override
  Future<Either<Failure, String>> call(Param<String> params) async {
    return await repo.addInsurance(params.data);
  }
}
