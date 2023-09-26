// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/features/owner/domain/entities/v.request.model.dart';
import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

import '../repository/owner.repo.dart';

class FetchRequests extends UseCase<List<VRequest>,Params<String>> {
  OwnerRepo repo;
  FetchRequests({
    required this.repo,
  });
  @override
  Future<Either<Failure, List<VRequest>>> call(Params<String> params) async {
    return await repo.fetchRequests(params.data);
  }
}
