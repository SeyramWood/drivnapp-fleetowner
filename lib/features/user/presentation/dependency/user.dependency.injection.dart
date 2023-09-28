import 'package:drivn/features/user/data/api/user.api.service.dart';
import 'package:drivn/features/user/domain/repositories/user.repo.dart';
import 'package:drivn/features/user/domain/usecases/login.dart';
import '../../../auth/presentation/providers/user.auth.provider.dart';
import '../../data/repositories/user.repo.impl.dart';
import '../../domain/usecases/create.dart';
import '../../domain/usecases/read.dart';
import '../../domain/usecases/submit.id.dart';

import 'package:get_it/get_it.dart';

import '../../domain/usecases/verify.fleetOwner.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register your dependencies here
  getIt.registerLazySingleton<UserApiService>(() => UserApiService());
  getIt.registerLazySingleton<UserRepo>(
    () => UserRepoImpl(getIt<UserApiService>()),
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
  getIt.registerLazySingleton<Login>(
    () => Login(repo: getIt<UserRepo>()),
  );
  getIt.registerLazySingleton<FetchOwnerProfile>(
    () => FetchOwnerProfile(repo: getIt<UserRepo>()),
  );getIt.registerLazySingleton<FetchDriverProfile>(
    () => FetchDriverProfile(repo: getIt<UserRepo>()),
  );
}

final userAuthProvider = UserAuthProvider(
  getIt<PostUseCase>(),
  getIt<VerifyUser>(),
  getIt<SubmitID>(),
  getIt<Login>(),
  getIt<FetchOwnerProfile>(),
  getIt<FetchDriverProfile>(),
);
