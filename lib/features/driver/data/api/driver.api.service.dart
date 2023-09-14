import 'package:drivn/features/driver/domain/entities/trips.model.dart';
import 'package:drivn/shared/utils/constants/base.url.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/request.model.dart';

class DriverApiService {
  Future<List<DRequest>> fetchRequest(String userID) async {
    final uri = Uri.parse('$baseUrl/booking/requests/driver/$userID');
    try {
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        print(response.reasonPhrase);
      }
      return driverRequestModelFromJson(response.body).data!.data;
    } catch (e) {
      print(e);
      throw Exception("couldn't fetch requests");
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
      if (response.statusCode != 200 || response.statusCode == 202) {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<DTrip>> fetchTrips(String userID) async {
    final uri = Uri.parse('$baseUrl/bookings/driver/$userID');
    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        print(response.statusCode);
      }
      return driverTripModelFromJson(response.body).data!.data;
    } catch (e) {
      print(e);
      throw Exception("couldn't fetch vehicles");
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
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future goOnline(String userID, String status) async {
    final url = Uri.parse(
        '$baseUrl/drivers/$userID/update-status/online?onlineStatus=$status');
    try {
      var response = await http.put(
        url,
      );
      if (response.statusCode != 200) {
        print('request failed with code:${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
