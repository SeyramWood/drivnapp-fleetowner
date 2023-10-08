import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/features/user/domain/entities/user.signup.model.dart';
import 'package:drivn/features/user/domain/usecases/login.dart';
import 'package:drivn/features/user/domain/usecases/read.dart';
import 'package:drivn/features/user/domain/usecases/submit.data.dart';
import 'package:drivn/features/user/domain/usecases/update.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../shared/show.snacbar.dart';
import '../../../../shared/utils/shared.prefs.manager.dart';
import '../../../../shared/utils/usecase.dart';
import '../../../user/domain/entities/driver.profile.model.dart';
import '../../../user/domain/entities/owner.profile.model.dart';
import '../../../user/domain/entities/driver.profile.model.dart' as driver;

import '../../../user/domain/usecases/create.dart';
import '../../../user/domain/usecases/logout.dart';
import '../../../user/domain/usecases/submit.doc.dart';
import '../../../user/domain/usecases/submit.id.dart';
import '../../../user/domain/usecases/update.profile.pic.dart';
import '../../../user/domain/usecases/verify.fleetOwner.dart';

class UserAuthProvider extends ChangeNotifier {
  final PostUseCase post;
  final VerifyUser verify;
  final SubmitDoc submitDoc;
  final SubmitId submitId;
  final Login login;
  final FetchOwnerProfile fetchOwner;
  final FetchDriverProfile fetchDriver;
  final SubmitData submitData;
  final UpdateUser updaTeUser;
  final UpdateProfilePic updateProfilePic;
  final LogOut logout;

  UserAuthProvider(
    this.post,
    this.verify,
    this.submitDoc,
    this.login,
    this.fetchOwner,
    this.fetchDriver,
    this.submitId,
    this.submitData,
    this.updaTeUser,
    this.updateProfilePic,
    this.logout,
  );

  String _userID = SharedPreferencesManager.instance.getString('userID', '');
  String get userID => _userID;

  Future<void> setUserId(String id) async {
    final prefs = SharedPreferencesManager.instance;
    await prefs.setString(
      'userID',
      id,
    );
    _userID = prefs.getString(
      'userID',
      '',
    );
    notifyListeners();
  }

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

//a secure storage to store access and refresh token
  final storage = const FlutterSecureStorage();

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

  Future logIn(String username, String password) async {
    _isLoading = true;
    final result = await login(MultiParams(username, password));
    return result.fold((failure) {
      _isLoading = false;
      notifyListeners();
      return failure.message;
    }, (success) async {
      _isLoading = false;
      await setUserId(success);
      notifyListeners();
    });
  }

  Future updateProfilePicture(File avatar, context) async {
    final result = await updateProfilePic(Params(avatar));
    return result.fold((failure) {
      showCustomSnackBar(context, failure.message);
    }, (success) {
      showCustomSnackBar(context, success);
    });
  }

  Future<Either<String, Profile>> fetchOwnerProfile(String iD) async {
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

  Future<Either<String, DProfile>> fetchDriverProfile(String iD) async {
    final result = await fetchDriver(Params(iD));
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
    final result = await verify(MultiParams(otp, _accountType));

    return result.fold(
      (failure) async {
        await Future.delayed(const Duration(seconds: 2));
        _isLoading = false;
        notifyListeners();
        return failure.message;
      },
      (success) async {
        _isLoading = false;
        await setUserId(success);
        notifyListeners();
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

  Future submitDriverDoc(String userID, driver.Document docs) async {
    _isLoading = true;
    notifyListeners();

    final result = await submitData(MultiParams(userID, docs));

    return result.fold(
      (failure) {
        _isLoading = false;
        notifyListeners();
        return failure.message;
      },
      (success) async {
        _isLoading = false;
        _filesToDB = [];
        notifyListeners();
        // return _filesToDB;
      },
    );
  }

//for the owner usage
  Future submitUserDoc(context, List<File> files, String userID) async {
    _isLoading = true;
    notifyListeners();

    final result = await submitDoc(MultiParams(files, userID));

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

  Future updateUser(
    String id,
    String requestBody,
    String accountType,
  ) async {
    final result =
        await updaTeUser(MultiParams(id, requestBody, data3: accountType));
    return result.fold((failure) {
      _isLoading = false;
      notifyListeners();
      return failure.message;
    }, (success) async {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<Either<String, String>> logOut() async {
    final result = await logout(NoParams());
    return result.fold(
      (failure) => Left(failure.message),
      (success) {
        
       return Right(success);
      },
    );
  }
}
