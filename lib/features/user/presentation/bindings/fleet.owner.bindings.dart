import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:drivn/features/user/domain/repositories/fleet.owner.repo.dart';
import 'package:drivn/features/user/domain/usecases/fleet.owner/create.dart';
import 'package:drivn/features/user/domain/usecases/fleet.owner/verify.fleetOwner.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/user.auth.provider.dart';
import '../../data/repositories/fleet.owner.repo.impl.dart';
import '../../domain/usecases/fleet.owner/submit.id.dart';

import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register your dependencies here
  getIt.registerLazySingleton<APIService>(() => APIService());
  getIt.registerLazySingleton<UserRepo>(
    () => FleetOwnerRepoImpl(getIt<APIService>()),
  );
  getIt.registerLazySingleton<PostUseCase>(
    () => PostUseCase(getIt<UserRepo>()),
  );
  getIt.registerLazySingleton<VerifyUser>(
    () => VerifyUser(getIt<UserRepo>()),
  );
  getIt.registerLazySingleton<SubmitID>(
    () => SubmitID(getIt<UserRepo>()),
  );
}

final userAuthProvider = UserAuthProvider(
  getIt<PostUseCase>(),
  getIt<VerifyUser>(),
  getIt<SubmitID>(),
);
  