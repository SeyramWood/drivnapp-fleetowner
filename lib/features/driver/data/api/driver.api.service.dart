import 'package:drivn/features/driver/domain/entities/trips.model.dart';
import 'package:drivn/shared/errors/exception.dart';
import 'package:drivn/shared/utils/constants/base.url.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/request.model.dart';

class DriverApiService {
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
