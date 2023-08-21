import 'package:drivn_app/features/user/domain/entities/user.model.dart';
import 'package:flutter/material.dart';

abstract class FleetOwnerDB {
   Future create(FleetOwner fleetOwner);
   Future read(FleetOwner fleetOwner);
   Future update(FleetOwner fleetOwner);
}


class FleetOwnerDBImpl extends ChangeNotifier implements FleetOwnerDB{
  @override
  Future create(FleetOwner fleetOwner) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future read(FleetOwner fleetOwner) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future update(FleetOwner fleetOwner) {
    // TODO: implement update
    throw UnimplementedError();
  }

}