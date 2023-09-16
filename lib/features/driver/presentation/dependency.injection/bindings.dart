import 'package:drivn/features/driver/data/api/driver.api.service.dart';
import 'package:drivn/features/driver/domain/repositories/driver.repo.dart';
import 'package:drivn/features/driver/domain/usecase/fetch.requests.dart';
import 'package:drivn/features/driver/domain/usecase/accept.request.dart';
import 'package:drivn/features/driver/domain/usecase/fetch.trips.dart';
import 'package:drivn/features/driver/domain/usecase/cancel.request.dart';
import 'package:drivn/features/driver/domain/usecase/go.online.dart';
import 'package:get_it/get_it.dart';

import '../../data/repository/driver.repo.impl.dart';
import '../provider/driver.impl.provider.dart';

final getIt = GetIt.instance;

void setupDriverDependencies() {
  // Register your repositories and services
  getIt.registerLazySingleton<DriverApiService>(() => DriverApiService());

  getIt.registerLazySingleton<DriverRepo>(
      () => DriverRepoImpl(getIt<DriverApiService>()));

  // Register your use cases
  getIt.registerLazySingleton<FetchRequest>(
      () => FetchRequest(getIt<DriverRepo>()));
  getIt.registerLazySingleton<AcceptRequest>(
      () => AcceptRequest(getIt<DriverRepo>()));
  getIt
      .registerLazySingleton<FetchTrips>(() => FetchTrips(getIt<DriverRepo>()));
  getIt.registerLazySingleton<CancelRequest>(
      () => CancelRequest(getIt<DriverRepo>()));
  getIt.registerLazySingleton<GoOnline>(() => GoOnline(getIt<DriverRepo>()));
}

final driverImplProvider = DriverImplProvider(
  getIt<FetchRequest>(),
  getIt<AcceptRequest>(),
  getIt<FetchTrips>(),
  getIt<CancelRequest>(),
  getIt<GoOnline>(),
);
