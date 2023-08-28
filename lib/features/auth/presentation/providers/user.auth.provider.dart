import 'dart:developer';
import 'dart:io';

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
      (success) {
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
    final result = await verify.call(Params(otp));
    return result.fold(
      (failure) {
        _isLoading = false;
        notifyListeners();
        print(failure.message);
        return failure.message;
      },
      (success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GetVerifiedOption(),
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
  Future<List<File>?> selectFiles() async {
    final fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (fileResult != null) {
      _filesToDB = fileResult.files
          .map((platformFile) => File(platformFile.path.toString()))
          .toList();
      notifyListeners();
      return _filesToDB;
    }
    return [];
  }

  Future submitUserID(context) async {
    _isLoading = true;
    notifyListeners();

    final result = await submitID.call(Params(_filesToDB ?? []));
    result.fold(
      (l) {
        log(l.message);
      },
      (r) {
        Navigator.of(context).pop();
        _isLoading = false;
        notifyListeners();
        return r;
      },
    );
    _filesToDB = [];
  }
}
