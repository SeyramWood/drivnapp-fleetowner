// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import '../../domain/entities/driver.profile.model.dart' as driver;
import 'package:drivn/features/user/domain/repositories/user.repo.dart';
import 'package:drivn/shared/errors/failure.dart';
import 'package:drivn/shared/utils/usecase.dart';

class SubmitData
    extends UseCase<String, MultiParams<String, driver.Document, String>> {
  UserRepo repo;
  SubmitData({
    required this.repo,
  });
  @override
  Future<Either<Failure, String>> call(
      MultiParams<String, driver.Document, String> params) async {
    return await repo.submitData(params.data1, params.data2);
  }
}
