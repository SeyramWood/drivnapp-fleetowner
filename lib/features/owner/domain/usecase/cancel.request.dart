// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

import '../repository/owner.repo.dart';

class CancelRequest extends UseCase<void,MultiParams<String,String,String>> {
  OwnerRepo repo;
 CancelRequest({
    required this.repo,
  });
  @override
  Future<Either<Failure, void>> call(MultiParams<String,String,String> params) async {
    return await repo.cancelRequest(params.data1,params.data2);
  }
}
