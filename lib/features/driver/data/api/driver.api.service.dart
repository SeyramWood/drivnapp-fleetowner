import 'package:drivn/shared/utils/constants/baseUrl.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/request.model.dart';

class DriverApiService {
  Future<List<DRequest>> fetchRequest(String userID) async {
    final uri = Uri.parse('$baseUrl/booking/requests/driver/$userID');
    try {
      final response = await http.get(uri);
      print(response.reasonPhrase);
      print(response.body);

      if (response.statusCode != 200) {
        print(response.reasonPhrase);
      }
      print(response.body);
      return driverRequestFromJson(response.body).data!.data;
    } catch (e) {
      print(e);
      throw Exception("couldn't fetch requests");
    }
  }
}
