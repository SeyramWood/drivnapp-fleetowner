import 'package:drivn/features/vehicle/domain/entities/vehicle.brands.dart';
import 'package:drivn/features/vehicle/domain/entities/vehicle.features.dart';
import 'package:drivn/features/vehicle/domain/entities/vehicle.type.dart';
import 'package:drivn/shared/errors/exception.dart';

import '../../../../shared/interceptor/http.client.interceptor.dart';
import '../../../../shared/utils/constants/base.url.dart';
import 'package:http/http.dart' as http;
final httpClient = http.Client();

class VehicleApiService {
  final customClient = HttpClientWithInterceptor(httpClient);
  Future<List<VType>> fetchTypes() async {
    const url= '$baseUrl/vehicle/types';
    try {
      final response = await customClient.get(url);
      if(response.statusCode!=200){
        throw CustomException('Couldn\'t fetch types');
      }
      if (response.statusCode == 200) {
        return vehicleTypeFromJson(response.body).data.data;
      } else {
        print('type status: ${response.statusCode} ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      print('Error while fetching features: $e');
      rethrow;
    }
  }

  Future<List<Feature>> fetchFeatures() async {
    const url= '$baseUrl/vehicle/features';
    http.Response? response;
    try {
      response = await customClient.get(url);
      if (response.statusCode != 200) {
        print(
            'feature status: ${response.statusCode} ${response.reasonPhrase}');
      }
      return vehicleFeatureFromJson(response.body).data.data;
    } catch (e) {
      print('Error while fetching features: $e');
      throw Exception('Failed to fetch features');
    }
  }

  Future<List<Brand>> fetchBrands() async {
    const url= '$baseUrl/vehicle/brands';
    try {
      final response = await customClient.get(url);
      if (response.statusCode == 200) {
        return vehicleBrandsFromJson(response.body).data.data;
      } else {
        print('brand status: ${response.statusCode} ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      print('Error while fetching features: $e');
      throw CustomException('Failed to fetch brands');
    }
  }
}
