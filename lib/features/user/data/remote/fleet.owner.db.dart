// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:drivn_app/features/user/domain/entities/fleetOwner.model.dart';

import '../api/fleet.owner.api.dart';

abstract class FleetOwnerDB extends ChangeNotifier {
  Future<FleetOwner> create(FleetOwner fleetOwner);
  Future<FleetOwner> read(FleetOwner fleetOwner);
  Future<FleetOwner> update(FleetOwner fleetOwner);
  Future<String> verify(String otp);
}

class FleetOwnerDBImpl extends ChangeNotifier implements FleetOwnerDB {
  FleetOwnerAPI api;
  FleetOwnerDBImpl(this.api);
  FleetOwnerDBImpl.empty() : api = FleetOwnerAPI();
  @override
  Future<FleetOwner> create(FleetOwner fleetOwner) async {
    final requestBody = fleetOwner;
    return await api.postFleetOwner(requestBody.toJson());
  }

  @override
  Future<FleetOwner> read(FleetOwner fleetOwner) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<FleetOwner> update(FleetOwner fleetOwner) {
    // TODO: implement update
    throw UnimplementedError();
  }
  
  @override
  Future<String> verify(String otp) async {
    return await api.verifyFleetOwner(otp);

  }
}
