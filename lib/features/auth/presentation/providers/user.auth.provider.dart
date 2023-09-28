import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/features/auth/presentation/views/verify.option.view.dart';
import 'package:drivn/features/user/domain/entities/user.signup.model.dart';
import 'package:drivn/features/user/domain/usecases/login.dart';
import 'package:drivn/features/user/domain/usecases/read.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../shared/errors/failure.dart';
import '../../../../shared/utils/usecase.dart';
import '../../../user/domain/entities/owner.profile.model.dart';
import '../../../user/domain/usecases/create.dart';
import '../../../user/domain/usecases/submit.id.dart';
import '../../../user/domain/usecases/verify.fleetOwner.dart';
import '../views/otp.input.view.dart';

class UserAuthProvider extends ChangeNotifier {
  final PostUseCase post;
  final VerifyUser verify;
  final SubmitID submitID;
  final Login login;
  final FetchOwnerProfile fetchOwner;
  final FetchDriverProfile fetchDriver;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserAuthProvider(
      this.post, this.verify, this.submitID, this.login, this.fetchOwner, this.fetchDriver);

  List<File>? _filesToDB;
  List<File>? get files => _filesToDB;

  Future<String?> postUser(SignUpBody fleetOwner, context) async {
    _isLoading = true;
    notifyListeners();

    final result = await post(Params(fleetOwner));
    return result.fold(
      (failure) async {
        await Future.delayed(const Duration(seconds: 2));
        _isLoading = false;
        notifyListeners();
        return failure.message;
      },
      (success) async {
        await Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OTPInputView(),
            ),
          );
        });

        _isLoading = false;
        notifyListeners();
        return null;
      },
    );
  }

  Future logIn(String username, String password) async {
    _isLoading = true;
    final result = await login(MultiParams(username, password));
    return result.fold((failure) {
      _isLoading = false;
      notifyListeners();
      return failure.message;
    }, (success) {
      _isLoading = false;
      notifyListeners();
      return success;
    });
  }

  Future<Either<String,Profile>> getOwnerProfile(String iD) async {
    final result = await fetchOwner(Params(iD));
    return result.fold(
      (failure) {
        return Left((failure.message));
      },
      (success) {
        return Right(success);
      },
    );
  }

  Future<String?> verifyUser(String otp, context) async {
    _isLoading = true;
    notifyListeners();
    final result = await verify(Params(otp));
    return result.fold(
      (failure) async {
        await Future.delayed(const Duration(seconds: 2));
        _isLoading = false;
        notifyListeners();
        return failure.message;
      },
      (success) async {
        await Future.delayed(const Duration(seconds: 2), () {
          _isLoading = false;
          notifyListeners();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VerifyOptionView(),
            ),
          );
        });

        return success;
      },
    );
  }

//select files to be uploaded
  Future<List<File>?> selectFiles({file}) async {
    final fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (fileResult != null) {
      file = _filesToDB = fileResult.files
          .map((platformFile) => File(platformFile.path.toString()))
          .toList();
      print(file);
      notifyListeners();
      return _filesToDB;
    }
    return [];
  }

//for the owner usage
  Future submitUserID(
    context,
  ) async {
    _isLoading = true;
    notifyListeners();

    final result = await submitID(Params(
      _filesToDB ?? [],
    ));
    result.fold(
      (failure) {
        log(failure.message);
      },
      (success) async {
        await Future.delayed(
          const Duration(seconds: 2),
          () => Navigator.of(context).pop(),
        );
        _isLoading = false;
        notifyListeners();
        return success;
      },
    );
    _filesToDB = [];
  }
}
