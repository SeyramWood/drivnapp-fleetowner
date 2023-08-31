import 'package:drivn/shared/utils/constants/baseUrl.dart';
import 'package:http/http.dart' as http;

class DriverApiService {
  Future fetchRequest(String userID) async {
    final uri = Uri.parse('$baseUrl/booking/requests/driver/$userID');
    try {
      final response = await http.get(uri);
      print(response.reasonPhrase);
      print(response.body);

      if (response.statusCode == 200) {
        print(response.body);
      }
    } catch (e) {}
  }
}
