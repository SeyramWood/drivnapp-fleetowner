// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:drivn/features/user/domain/repositories/user.repo.dart';
import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

import '../entities/driver.profile.model.dart';
import '../entities/owner.profile.model.dart';

class FetchOwnerProfile extends UseCase<Profile, Params> {
  UserRepo repo;
  FetchOwnerProfile({
    required this.repo,
  });
  @override
  Future<Either<Failure, Profile>> call(Params params) async {
    return await repo.fetchOwnerProfile(params.data);
  }
}

class FetchDriverProfile extends UseCase<DProfile, Params> {
  UserRepo repo;
  FetchDriverProfile({
    required this.repo,
  });
  @override
  Future<Either<Failure, DProfile>> call(Params params) async {
    return await repo.fetchDriverProfile(params.data);
  }
}
