import 'package:drivn/features/owner/domain/usecase/update.rental.dart';
import 'package:get_it/get_it.dart';

import '../../domain/usecase/accept.request.dart';
import '../../domain/usecase/cancel.request.dart';
import '../../data/api/owner.api.dart';
import '../../data/repository/owner.repo.impl.dart';
import '../../domain/repository/owner.repo.dart';
import '../../domain/usecase/add.vehicle.dart';
import '../../domain/usecase/delete.vehicle.dart';
import '../../domain/usecase/fetch.booked.vehicles.dart';
import '../../domain/usecase/fetch.driver.dart';
import '../../domain/usecase/fetch.requests.dart';
import '../../domain/usecase/fetch.vehicles.dart';
import '../../domain/usecase/update.availability.dart';

final getIt = GetIt.instance;

void setupOwnerDependencies() {
  // Register the OwnerApiService as a singleton
  getIt.registerLazySingleton<OwnerApiService>(() => OwnerApiService());

  // Register the OwnerRepoImpl with its dependencies
  getIt.registerLazySingleton<OwnerRepo>(
    () => OwnerRepoImpl(apiService: getIt<OwnerApiService>()),
  );

  // Register your use case classes with their dependencies
  getIt.registerLazySingleton<AcceptRequest>(
      () => AcceptRequest(repo: getIt<OwnerRepo>()));
  getIt.registerLazySingleton<AddVehicle>(
      () => AddVehicle(repo: getIt<OwnerRepo>()));
  getIt.registerLazySingleton<CancelRequest>(
      () => CancelRequest(repo: getIt<OwnerRepo>()));
  getIt.registerLazySingleton<DeleteVehicle>(
      () => DeleteVehicle(repo: getIt<OwnerRepo>()));
  getIt.registerLazySingleton<FetchBookedVehicles>(
      () => FetchBookedVehicles(repo: getIt<OwnerRepo>()));
  getIt.registerLazySingleton<FetchDrivers>(
      () => FetchDrivers(repo: getIt<OwnerRepo>()));
  getIt.registerLazySingleton<FetchRequests>(
      () => FetchRequests(repo: getIt<OwnerRepo>()));
  getIt.registerLazySingleton<FetchVehicles>(
      () => FetchVehicles(repo: getIt<OwnerRepo>()));
  getIt.registerLazySingleton<UpdateAvailability>(
      () => UpdateAvailability(repo: getIt<OwnerRepo>()));
  getIt.registerLazySingleton<UpdateRental>(
      () => UpdateRental(repo: getIt<OwnerRepo>()));
}
