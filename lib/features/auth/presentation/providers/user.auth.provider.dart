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
import '../../../../shared/utils/shared.prefs.manager.dart';
import '../../../../shared/utils/usecase.dart';
import '../../../user/domain/entities/owner.profile.model.dart';
import '../../../user/domain/usecases/create.dart';
import '../../../user/domain/usecases/submit.doc.dart';
import '../../../user/domain/usecases/submit.id.dart';
import '../../../user/domain/usecases/verify.fleetOwner.dart';
import '../views/otp.input.view.dart';

class UserAuthProvider extends ChangeNotifier {
  final PostUseCase post;
  final VerifyUser verify;
  final SubmitDoc submitDoc;
  final SubmitId submitId;
  final Login login;
  final FetchOwnerProfile fetchOwner;
  final FetchDriverProfile fetchDriver;

  UserAuthProvider(
    this.post,
    this.verify,
    this.submitDoc,
    this.login,
    this.fetchOwner,
    this.fetchDriver,
    this.submitId,
  );

  final String _userID =
      SharedPreferencesManager.instance.getString('userID', '');
  String get userID => _userID;

  String _accountType = '';
  String get accountType => _accountType;
  isOwner(String thisAccount) {
    _accountType = thisAccount;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(loading) {
    _isLoading = loading;
  }

  List<File> _filesToDB = [];
  List<File> get files => _filesToDB;
  emptyFiles() {
    _filesToDB = [];
    notifyListeners();
  }

  Future postUser(SignUpBody fleetOwner, context) async {
    _isLoading = true;
    notifyListeners();

    final result = await post(MultiParams(fleetOwner, _accountType));
    return result.fold(
      (failure) async {
        _isLoading = false;
        notifyListeners();
        return failure.message;
      },
      (success) async {
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<String?> logIn(String username, String password) async {
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

  Future<Either<String, Profile>> getOwnerProfile(String iD) async {
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

  Future verifyUser(String otp, context) async {
    _isLoading = true;
    notifyListeners();
    final result = await verify(MultiParams(otp,_accountType));
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
        });
      },
    );
  }

//select files to be uploaded
  Future<List<File>> selectFiles({file}) async {
    final fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (fileResult != null) {
      file = _filesToDB = fileResult.files
          .map((platformFile) => File(platformFile.path.toString()))
          .toList();
      notifyListeners();
      return _filesToDB;
    }
    return [];
  }

//for the owner usage
  Future submitUserDoc(context, List<File> files, String userID) async {
    _isLoading = true;
    notifyListeners();

    final result = await submitDoc(MultiParams(files, userID));
    print(result);

    return result.fold(
      (failure) {
        _isLoading = false;
        notifyListeners();
        return failure.message;
      },
      (success) async {
        await Future.delayed(
          const Duration(seconds: 2),
          () => Navigator.of(context).pop(),
        );
        _isLoading = false;
        _filesToDB = [];
        notifyListeners();
        // return _filesToDB;
      },
    );
  }

  Future submitUserId(context, List<File> files, String userID) async {
    _isLoading = true;
    notifyListeners();

    final result = await submitId(MultiParams(files, userID));

    return result.fold(
      (failure) {
        _isLoading = false;
        notifyListeners();
        return failure.message;
      },
      (success) async {
        await Future.delayed(
          const Duration(seconds: 2),
          () => Navigator.of(context).pop(),
        );
        _isLoading = false;
        _filesToDB = [];
        notifyListeners();
        // return _filesToDB;
      },
    );
  }
}
