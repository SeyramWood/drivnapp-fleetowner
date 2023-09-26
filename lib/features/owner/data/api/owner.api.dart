import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:drivn/features/owner/domain/entities/booked.vehicle.model.dart';
import 'package:drivn/features/owner/domain/entities/v.request.model.dart';
import 'package:drivn/features/owner/domain/entities/vehicle.model.dart' as v;
import 'package:drivn/shared/errors/exception.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/utils/constants/base.url.dart';
import '../../domain/entities/driver.model.dart';
import '../../domain/entities/update.rental.model.dart';

class OwnerApiService {
  //add a vehicle
  Future addVehicle({required v.VehicleToDBModel vehicle}) async {
    final uri = Uri.parse('$baseUrl/vehicles');

    try {
      if (vehicle.images.isNotEmpty && vehicle.documents.isNotEmpty) {
        var request = http.MultipartRequest('POST', uri);
        // Add fields to the request
        request.fields['owner'] = vehicle.userID;
        request.fields['brand'] = vehicle.brand;
        request.fields['type'] = vehicle.type;
        request.fields['feature'] = vehicle.features.join(',');
        request.fields['moreFeature'] = vehicle.moreFeatures ?? '';

        for (var file in vehicle.images) {
          request.files.add(
            await http.MultipartFile.fromPath('image', file.path),
          );
        }

        for (var file in vehicle.documents) {
          request.files.add(
            await http.MultipartFile.fromPath('document', file.path),
          );
        }

        var response = await request.send();

        if (response.statusCode != 201) {
          throw CustomException("Couldn't create or add vehicle");
        }
      } else {
        throw CustomException('No files selected');
      }
    } catch (failure) {
      rethrow;
    }
  }

//http get request for vehicles belonging to a user
  Future<List<v.Vehicle>> fetchVehicles(String userID) async {
    final uri = Uri.parse('$baseUrl/vehicles/owner/$userID');
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      print(
        '${response.statusCode}\n${response.reasonPhrase}\n${response.body}',
      );
    }
    return v.vehicleFromJson(response.body).data!.data;
  }

  Future<List<BookedVehicle>> fetchBookedVehicles(String userID) async {
    final uri = Uri.parse('$baseUrl/bookings/owner/$userID');
    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        print(response.statusCode);
      }
      return bookedVehicleModelFromJson(response.body).data!.data;
    } catch (e) {
      print(e);
      throw Exception("couldn't fetch vehicles");
    }
  }

  Future updateRental(
      String vehicleID, UpdateRentalModel updateRentalModel) async {
    final url = Uri.parse('$baseUrl/vehicles/rental/$vehicleID');
    final body = updateRentalModel.updateRentalToJson();
    try {
      final response = await http.put(url, body: body);
      if (response.statusCode != 200) {
        throw CustomException("Rental couldn't be updated");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateAvailability(
    String vehicleID,
    String status,
  ) async {
    final url =
        Uri.parse('$baseUrl/vehicles/availability/$vehicleID?status=$status');

    try {
      final response = await http.put(url);

      if (response.statusCode != 200 || response.statusCode != 202) {
        throw CustomException("Availability couldn't be updated");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Dryver>> fetchDrivers() async {
    final url = Uri.parse('$baseUrl/drivers?approved=true&assigned=false');
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        log(response.statusCode.toString());
      }
      return DriverModel.fromJson(json.decode(response.body)).data.data;
    } catch (e) {
      throw Exception('failed to get drivers');
    }
  }

  Future<List<VRequest>> allRequests(String userID) async {
    final url = Uri.parse('$baseUrl/booking/requests/owner/$userID');
    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        print(response.statusCode);
      }
      return vehicleRequestModelFromJson(response.body).data!.data;
    } catch (e) {
      print(e);
      throw Exception("couldn't fetch request");
    }
  }

  Future acceptRequest(String requestID) async {
    final url = Uri.parse('$baseUrl/booking/requests/accept/$requestID');
    try {
      final body = {
        "requestType": "owner",
        "status": "accepted",
      };
      final response = await http.put(url, body: body);
      if (response.statusCode != 200 || response.statusCode == 202) {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future cancelRequest(String requestID, String? reason) async {
    final url = Uri.parse('$baseUrl/booking/requests/accept/$requestID');
    final body = {
      "requestType": "owner",
      "status": "declined",
      'reason': reason
    };
    try {
      final response = await http.put(url, body: body);
      if (response.statusCode != 200) {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future deleteVehicle(String vehicleID) async {
    final url = Uri.parse('$baseUrl/vehicles/$vehicleID');
    try {
      final response = await http.delete(url);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }
}
