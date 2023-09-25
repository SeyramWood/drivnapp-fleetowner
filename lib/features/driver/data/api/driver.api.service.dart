import 'dart:convert';

import 'package:drivn/features/driver/domain/entities/trips.model.dart';
import 'package:drivn/shared/errors/exception.dart';
import 'package:drivn/shared/utils/constants/base.url.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/utils/shared.prefs.manager.dart';
import '../../domain/entities/driver.model.dart';
import '../../domain/entities/request.model.dart';

class DriverApiService {
  //set driver needed variables
  Future onInit(String userID) async {
    final prefs = SharedPreferencesManager.instance;
    final url = Uri.parse('$baseUrl/drivers/$userID');
    try {
      final response = await http.get(url);
      final responseBody = jsonDecode(response.body)['data'];

      if (response.statusCode != 200) {
        print('failed with:${response.reasonPhrase}');
      }
      if (response.statusCode == 200) {
        await prefs.setString(
          'isOnline',
          responseBody['status'],
        );
        await prefs.setString(
          'cardStatus',
          responseBody['document']['cardStatus'],
        );
        await prefs.setString(
          'licenseStatus',
          responseBody['document']['licenseStatus'],
        );
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<DriverObject> fetchDriver(String userID) async {
    final url = Uri.parse('$baseUrl/drivers/$userID');
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        print('user fetch failed with: ${response.statusCode}');
      }
      return DriverObject.fromJson(json.decode(response.body));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<DRequest>> fetchRequest(String userID) async {
    final uri = Uri.parse('$baseUrl/booking/requests/driver/$userID');
    try {
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw CustomException("couldn't fetch requests");
      }
      return driverRequestModelFromJson(response.body).data!.data;
    } catch (e) {
      rethrow;
    }
  }

  Future acceptRequest(String requestID) async {
    final url = Uri.parse('$baseUrl/booking/requests/accept/$requestID');
    try {
      final body = {
        "requestType": "driver",
        "status": "accepted",
        "reason": ""
      };
      final response = await http.put(url, body: body);
      if (response.statusCode != 200) {
        throw CustomException('An error occurred');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DTrip>> fetchTrips(String userID) async {
    final uri = Uri.parse('$baseUrl/bookings/driver/$userID');
    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        CustomException("couldn't fetch vehicles");
      }
      return driverTripModelFromJson(response.body).data!.data;
    } catch (e) {
      rethrow;
    }
  }

  Future cancelRequest(String requestID, String reason) async {
    final url = Uri.parse('$baseUrl/booking/requests/accept/$requestID');
    final body = {
      "requestType": "driver",
      "status": "declined",
      "reason": reason
    };
    try {
      final response = await http.put(url, body: body);
      if (response.statusCode != 200) {
        throw CustomException('Could not cancel request.Retry!');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateTripStatus(String bookingID, String status) async {
    final url = Uri.parse('$baseUrl/bookings/$bookingID/trip-status/$status');
    try {
      final response = await http.put(url);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
    }
  }

  Future goOnline(String userID, String status) async {
    final url = Uri.parse('$baseUrl/drivers/$userID/update-status/$status');
    try {
      final body = {'onlineStatus': status};
      var response = await http.put(url, body: body);
      if (response.statusCode != 200) {
        throw CustomException("Couldn't switch.Retry!");
      }
    } catch (e) {
      rethrow;
    }
  }
}
