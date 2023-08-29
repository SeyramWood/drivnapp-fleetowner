import 'dart:developer';
import 'dart:io';

import 'package:drivn/features/auth/presentation/views/verify.option.view.dart';
import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:drivn/features/user/domain/entities/user.signup.model.dart';
import 'package:drivn/features/user/domain/usecases/fleet.owner/create.dart';
import 'package:drivn/features/user/domain/usecases/fleet.owner/submit.id.dart';
import 'package:drivn/shared/errors/error.alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/usecase.dart';
import '../../../user/domain/usecases/fleet.owner/verify.fleetOwner.dart';
import '../views/otp.input.view.dart';
import '../views/verifyOwner/verify.user.view.dart';

class UserAuthProvider extends ChangeNotifier {
  final PostUseCase post;
  final VerifyUser verify;
  final SubmitID submitID;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserAuthProvider(this.post, this.verify, this.submitID);
  UserAuthProvider.empty()
      : post = PostUseCase.empty(),
        verify = VerifyUser.empty(),
        submitID = SubmitID.empty();
  List<File>? _filesToDB;
  List<File>? get files => _filesToDB;

  Future<String?> postUser(SignUpBody fleetOwner, context) async {
    _isLoading = true;
    notifyListeners();

    final result = await post(Params(fleetOwner));
    return result.fold(
      (failure) {
        _isLoading = false;
        notifyListeners();
        return failure.message;
      },
      (success) async {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OTPInputView(),
          ),
        );
        _isLoading = false;
        notifyListeners();
        return null;
      },
    );
  }

  Future<String?> verifyUser(String otp, context) async {
    _isLoading = true;
    notifyListeners();
    final result = await verify(Params(otp));
    return result.fold(
      (failure) {
        _isLoading = false;
        notifyListeners();
        print(failure.message);
        return failure.message;
      },
      (success) async {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VerifyOptionView(),
          ),
        );
        _isLoading = false;
        notifyListeners();
        print('verified');
        return null;
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
        await Future.delayed(const Duration(seconds: 2));
        Navigator.of(context).pop();
        _isLoading = false;
        notifyListeners();
        return success;
      },
    );
    _filesToDB = [];
  }
}
