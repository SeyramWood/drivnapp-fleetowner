import 'package:dartz/dartz.dart';
import 'package:drivn_app/features/user/domain/entities/fleetOwner.model.dart';
import 'package:drivn_app/features/user/domain/usecases/fleet.owner/create.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/usecase.dart';
import '../../../user/domain/usecases/fleet.owner/verify.fleetOwner.dart';
import '../views/otp.input.view.dart';
import '../views/verifyOwner/verify.user.view.dart';

class FleetOwnerProvider extends ChangeNotifier {
  final PostUseCase post;
  final VerifyFleetOwner verify;

  FleetOwnerProvider(this.post, this.verify);
  FleetOwnerProvider.empty()
      : post = PostUseCase.empty(),
        verify = VerifyFleetOwner.empty();

  Future<void> postFleetOwner(FleetOwner fleetOwner, context) async {
    final result = await post.call(Params(fleetOwner));
    result.fold(
      (l) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OTPInputView(),
          ),
        );
        print('created');
        return l;
      },
      (r) => print('Could not create'),
    );
  }

  Future<void> verifyFleetOwner(String otp, context) async {
    final result = await verify.call(Params(otp));
    result.fold(
      (l) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GetVerifiedOption(),
          ),
        );
        print('created');
        return l;
      },
      (r) => print('Could not create'),
    );
  }
}
