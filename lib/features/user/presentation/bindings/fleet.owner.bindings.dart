import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:drivn/features/user/domain/repositories/fleet.owner.repo.dart';
import 'package:drivn/features/user/domain/usecases/fleet.owner/create.dart';
import 'package:drivn/features/user/domain/usecases/fleet.owner/verify.fleetOwner.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/user.auth.provider.dart';
import '../../data/repositories/fleet.owner.repo.impl.dart';
import '../../domain/usecases/fleet.owner/submit.id.dart';

class UserBindings {
  ChangeNotifierProvider<APIService> apiService =
      ChangeNotifierProvider<APIService>(
    create: (context) => APIService(),
  );

  final userRepo = ChangeNotifierProxyProvider<APIService, UserRepo>(
    create: (context) => FleetOwnerRepoImpl.empty(),
    update: (context, db, previous) => FleetOwnerRepoImpl(db),
  );

  final postUser = ChangeNotifierProxyProvider<UserRepo, PostUseCase>(
    create: (context) => PostUseCase.empty(),
    update: (context, fleetOwnerRepo, previous) => PostUseCase(fleetOwnerRepo),
  );

  final verifUser = ChangeNotifierProxyProvider<UserRepo, VerifyUser>(
    create: (context) => VerifyUser.empty(),
    update: (context, fleetOwnerRepo, previous) => VerifyUser(fleetOwnerRepo),
  );
  final submitID = ChangeNotifierProxyProvider<UserRepo, SubmitID>(
    create: (context) => SubmitID.empty(),
    update: (context, fleetOwnerRepo, previous) => SubmitID(fleetOwnerRepo),
  );

  final userAuthProvider =
      ChangeNotifierProxyProvider<PostUseCase, UserAuthProvider>(
    create: (context) => UserAuthProvider.empty(),
    update: (context, postUseCase, previous) => UserAuthProvider(
        postUseCase, context.read<VerifyUser>(), context.read<SubmitID>()),
  );
}
