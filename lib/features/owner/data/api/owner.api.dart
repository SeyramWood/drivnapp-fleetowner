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

class OwnerApiService {
  //add a vehicle
  Future<String?> addVehicle({
    required String userID,
    required String carBrand,
    required String carType,
    required List<File> imageFiles,
    required List<File> proofFiles,
    required List<String> features,
    String? moreFeatures,
  }) async {
    final uri = Uri.parse('$baseUrl/vehicles');

    try {
      if (imageFiles.isNotEmpty && proofFiles.isNotEmpty) {
        var request = http.MultipartRequest('POST', uri);
        // Add fields to the request
        request.fields['owner'] = userID;
        request.fields['brand'] = carBrand;
        request.fields['type'] = carType;
        request.fields['feature'] = features.join(',');

        request.fields['moreFeature'] = moreFeatures ?? '';

        for (var file in imageFiles) {
          request.files.add(
            await http.MultipartFile.fromPath('image', file.path),
          );
        }

        for (var file in proofFiles) {
          request.files.add(
            await http.MultipartFile.fromPath('document', file.path),
          );
        }

        var response = await request.send();

        if (response.statusCode != 201) {
          print(response.reasonPhrase);
          throw CustomException(
              'Request failed with status code: ${response.statusCode}');
        }
        log(response.stream.bytesToString.toString());
      } else {
        print('No files selected');
      }
    } on CustomException catch (failure) {
      print('CustomException: ${failure.message}');
      // throw CustomException(failure.message);
    } catch (e) {
      print('Error: $e');
      rethrow; // Re-throw the caught exception for better error propagation
    }
    return null;
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
    String vehicleID,
    String? driver,
    String location,
    String price,
  ) async {
    final url = Uri.parse('$baseUrl/vehicles/rental/$vehicleID');
    final body = {
      "driver": driver ?? '',
      "location": location,
      "price": price,
    };
    try {
      final response = await http.put(url, body: body);

      if (response.statusCode != 200 || response.statusCode != 202) {
        log(response.statusCode.toString());
      }
      log(response.body);
    } catch (e) {
      log('$e');
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
        log(response.statusCode.toString());
      }
      log(response.body);
    } catch (e) {
      log('$e');
    }
  }

  Future<List<Dryver>> fetchDrivers() async {
    final url = Uri.parse('$baseUrl/drivers?approved=true&assigned=false');
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        log(response.statusCode.toString());
      }
      log(response.body.toString());
      return DriverModel.fromJson(json.decode(response.body)).data.data;
    } catch (e) {
      print(e);
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

  Future cancelRequest(requestID, String? reason) async {
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

  Future endTrip(String bookingID) async {
    final url = Uri.parse('$baseUrl/bookings/$bookingID/trip-status/ended');
    try {
      final response = await http.put(url);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
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
