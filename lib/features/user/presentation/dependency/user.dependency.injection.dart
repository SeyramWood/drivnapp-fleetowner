import 'package:drivn/features/user/data/api/user.api.service.dart';
import 'package:drivn/features/user/domain/repositories/user.repo.dart';
import 'package:drivn/features/user/domain/usecases/login.dart';
import 'package:drivn/features/user/domain/usecases/submit.data.dart';
import 'package:drivn/features/user/domain/usecases/update.profile.pic.dart';
import '../../../auth/presentation/providers/user.auth.provider.dart';
import '../../data/repositories/user.repo.impl.dart';
import '../../domain/usecases/create.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/read.dart';
import '../../domain/usecases/submit.doc.dart';

import 'package:get_it/get_it.dart';

import '../../domain/usecases/submit.id.dart';
import '../../domain/usecases/update.dart';
import '../../domain/usecases/verify.fleetOwner.dart';

final getIt = GetIt.instance;

void setupUserDependencies() {
  // Register your dependencies here
  getIt.registerLazySingleton<UserApiService>(() => UserApiService());
  getIt.registerLazySingleton<UserRepo>(
      () => UserRepoImpl(getIt<UserApiService>()));
  getIt
      .registerLazySingleton<PostUseCase>(() => PostUseCase(getIt<UserRepo>()));
  getIt.registerLazySingleton<VerifyUser>(
    () => VerifyUser(getIt<UserRepo>()),
  );
  getIt.registerLazySingleton<SubmitDoc>(() => SubmitDoc(getIt<UserRepo>()));
  getIt.registerLazySingleton<Login>(
    () => Login(repo: getIt<UserRepo>()),
  );
  getIt.registerLazySingleton<FetchOwnerProfile>(
    () => FetchOwnerProfile(repo: getIt<UserRepo>()),
  );
  getIt.registerLazySingleton<FetchDriverProfile>(
    () => FetchDriverProfile(repo: getIt<UserRepo>()),
  );
  getIt.registerLazySingleton<SubmitId>(
    () => SubmitId(repo: getIt<UserRepo>()),
  );
  getIt.registerLazySingleton<SubmitData>(
    () => SubmitData(repo: getIt<UserRepo>()),
  );
  getIt.registerLazySingleton<UserAuthProvider>(() => userAuthProvider);
  getIt.registerLazySingleton<UpdateUser>(
    () => UpdateUser(repo: getIt<UserRepo>()),
  );
  getIt.registerLazySingleton<UpdateProfilePic>(
    () => UpdateProfilePic(repo: getIt<UserRepo>()),
  );
  getIt.registerLazySingleton<LogOut>(
    () => LogOut(repo: getIt<UserRepo>()),
  );
}

final userAuthProvider = UserAuthProvider(
  getIt<PostUseCase>(),
  getIt<VerifyUser>(),
  getIt<SubmitDoc>(),
  getIt<Login>(),
  getIt<FetchOwnerProfile>(),
  getIt<FetchDriverProfile>(),
  getIt<SubmitId>(),
  getIt<SubmitData>(),
  getIt<UpdateUser>(),
  getIt<UpdateProfilePic>(),
  getIt<LogOut>(),
);
