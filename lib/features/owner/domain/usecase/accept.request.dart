// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/shared/errors/failure.dart';

import '../../../../shared/utils/usecase.dart';
import '../repository/owner.repo.dart';

class AcceptRequest extends UseCase<void,Params<String>> {
  OwnerRepo repo;
  AcceptRequest({
    required this.repo,
  });
  @override
  Future<Either<Failure, void>> call(Params<String> params) async {
  return await repo.acceptRequest(params.data);
  }
}
