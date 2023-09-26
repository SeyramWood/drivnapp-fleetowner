// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/shared/errors/failure.dart';

import '../../../../shared/utils/usecase.dart';
import '../repository/owner.repo.dart';

class UpdateAvailability extends UseCase<void,MultiParams<String,String>> {
  OwnerRepo repo;
  UpdateAvailability({
    required this.repo,
  });
  @override
  Future<Either<Failure, void>> call(MultiParams<String, String> params) async {
    return await repo.updateAvailability(params.data1,params.data2);
  }
}
