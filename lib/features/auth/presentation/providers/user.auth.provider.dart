import 'dart:developer';

import 'package:drivn_app/features/user/domain/entities/user.signup.model.dart';
import 'package:drivn_app/features/user/domain/usecases/fleet.owner/create.dart';
import 'package:drivn_app/features/user/domain/usecases/fleet.owner/submitID.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../shared/utils/usecase.dart';
import '../../../user/domain/usecases/fleet.owner/verify.fleetOwner.dart';
import '../views/otp.input.view.dart';
import '../views/verifyOwner/verify.user.view.dart';

class UserAuthProvider extends ChangeNotifier {
  final PostUseCase post;
  final VerifyUser verify;
  final SubmitID submitID;
  bool isLoading = false;
  UserAuthProvider(this.post, this.verify, this.submitID);
  UserAuthProvider.empty()
      : post = PostUseCase.empty(),
        verify = VerifyUser.empty(),
        submitID = SubmitID.empty();
  List<MultipartFile>? files;

  void postUser(SignUpBody fleetOwner, context) async {
    final result = await post.call(Params(fleetOwner));
    result.fold(
      (l) => print(l.message),
      (r) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OTPInputView(),
          ),
        );
        return r;
      },
    );
  }

  Future<void> verifyUser(String otp, context) async {
    final result = await verify.call(Params(otp));
    result.fold(
      (l) => print('error 1 :' + l.message),
      (r) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GetVerifiedOption(),
          ),
        );
        print('verified');
        return r;
      },
    );
  }

//select files to be uploaded
  Future<List<MultipartFile>?> selectFiles() async {
    final fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
    List<MultipartFile>? _files;
    if (fileResult != null) {
      _files = fileResult.files
          // .where((file) => file.bytes != null)
          .map(
            (file) => MultipartFile.fromBytes(
              'file',
              file.bytes ?? [],
              filename: file.name,
            ),
          )
          .toList();
      files = await _files;
      print('files :${_files.length}');

      return await _files;
    }
    return [];
  }

  Future submitUserID(context) async {
    final result = await submitID.call(Params(files!));
    result.fold(
      (l) => print(l.message),
      (r) {
        Navigator.of(context).pop();
        return r;
      },
    );
    files = [];
  }
}
