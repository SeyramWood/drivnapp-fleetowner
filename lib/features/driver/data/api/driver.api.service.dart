import 'dart:convert';

import 'package:drivn/features/driver/domain/entities/trips.model.dart';
import 'package:drivn/shared/errors/exception.dart';
import 'package:drivn/shared/utils/constants/base.url.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/interceptor/http.client.interceptor.dart';
import '../../../../shared/utils/shared.prefs.manager.dart';
import '../../../owner/presentations/dependency/owner.dependency.injection.dart';
import '../../domain/entities/driver.model.dart';
import '../../domain/entities/request.model.dart';

final httpClient = http.Client();

class DriverApiService {
  final storage = getIt<FlutterSecureStorage>();
  final customClient = HttpClientWithInterceptor(httpClient);
  //set driver needed variables
  Future onInit(String userID) async {
    final prefs = SharedPreferencesManager.instance;

    final url = '$baseUrl/drivers/$userID';
    try {
      final response = await customClient.get(url);
      final responseBody = jsonDecode(response.body)['data'];

      if (response.statusCode != 200) {
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
      return;
    }
  }

  Future<DriverObject> fetchDriver(String userID) async {
    final url = '$baseUrl/drivers/$userID';
    try {
      final response = await customClient.get(url);
      if (response.statusCode != 200) {
      }
      return DriverObject.fromJson(json.decode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DRequest>> fetchRequest(String userID) async {
    final uri = '$baseUrl/booking/requests/driver/$userID';
    try {
      final response = await customClient.get(uri);

      if (response.statusCode != 200) {
        throw CustomException("couldn't fetch requests");
      }
      return driverRequestModelFromJson(response.body).data!.data;
    } catch (e) {
      rethrow;
    }
  }

  Future acceptRequest(String requestID) async {
    final url = '$baseUrl/booking/requests/accept/$requestID';
    try {
      final body = {
        "requestType": "driver",
        "status": "accepted",
        "reason": ""
      };
      final response = await customClient.put(url, body: body);
      if (response.statusCode != 200) {
        throw CustomException('An error occurred');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DTrip>> fetchTrips(String userID) async {
    final uri = '$baseUrl/bookings/driver/$userID';
    try {
      final response = await customClient.get(uri);
      if (response.statusCode != 200) {
        CustomException("couldn't fetch vehicles");
      }
      return driverTripModelFromJson(response.body).data!.data;
    } catch (e) {
      rethrow;
    }
  }

  Future cancelRequest(String requestID, String reason) async {
    final url = '$baseUrl/booking/requests/accept/$requestID';
    final body = {
      "requestType": "driver",
      "status": "declined",
      "reason": reason
    };
    try {
      final response = await customClient.put(url, body: body);
      if (response.statusCode != 200) {
        throw CustomException('Could not cancel request.Retry!');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateTripStatus(String bookingID, String status) async {
    final url = '$baseUrl/bookings/$bookingID/trip-status/$status';
    try {
      final response = await customClient.put(url);
      if (response.statusCode != 200) {
      }
    } catch (e) {
    }
  }

  Future goOnline(String userID, String status) async {
    final url = '$baseUrl/drivers/$userID/update-status/$status';
    try {
      final body = {'onlineStatus': status};
      var response = await customClient.put(url, body: body);
      if (response.statusCode != 200) {
        throw CustomException("Couldn't switch.Retry!");
      }
    } catch (e) {
      rethrow;
    }
  }
}
