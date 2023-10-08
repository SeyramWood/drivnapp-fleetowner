// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

import '../repositories/user.repo.dart';

class UpdateProfilePic extends UseCase<String,Params<File>> {
  UserRepo repo;
  UpdateProfilePic({
    required this.repo,
  });
  @override
  Future<Either<Failure, String>> call(Params<File> params) async {
    return await repo.updateProfilePic(params.data);
  }
}
