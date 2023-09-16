import 'dart:math';

import 'package:drivn/features/driver/domain/entities/request.model.dart';
import 'package:drivn/features/driver/domain/usecase/cancel.request.dart';
import 'package:drivn/features/driver/domain/usecase/fetch.requests.dart';
import 'package:drivn/features/driver/domain/usecase/fetch.trips.dart';
import 'package:drivn/features/driver/domain/usecase/go.online.dart';
import 'package:drivn/shared/utils/usecase.dart';
import 'package:flutter/material.dart';
import '../../domain/usecase/accept.request.dart';

class DriverImplProvider extends ChangeNotifier {
  final FetchRequest _fetchRequest;
  final AcceptRequest _acceptRequest;
  final FetchTrips _fetchTrips;
  final CancelRequest _cancelRequest;
  final GoOnline _goOnline;

  DriverImplProvider(
    this._fetchRequest,
    this._acceptRequest,
    this._fetchTrips,
    this._cancelRequest,
    this._goOnline,
  );

  Future<List<DRequest>> fetchRequest(String userID) async {
    final result = await _fetchRequest(Params(userID));
    return result.fold(
      (failure) {
        print(failure.message);

        return [];
      },
      (success) => success,
    );
  }

  Future acceptRequest(String requestID) async {
    final result = await _acceptRequest(Params(requestID));
    return result.fold(
      (failure) => failure.message,
      (success) => success,
    );
  }

  Future fetchTrips(String userID) async {
    final result = await _fetchTrips(Params(userID));
    return result.fold(
      (failure) => failure.message,
      (succes) => succes,
    );
  }

  Future cancelRequest(String requestID, String reason) async {
    final result = await _cancelRequest(MultiParams(requestID, reason));
    return result.fold(
      (failure) => failure.message,
      (success) => success,
    );
  }

  Future goOnline(String userID, String status) async {
    final result = await _goOnline(MultiParams(userID, status));
    return result.fold(
      (failure) => failure.message,
      (success) => success,
    );
  }
}
