import 'dart:convert';

import 'package:drivn/features/vehicle/domain/entities/vehicle.brands.dart';
import 'package:drivn/features/vehicle/domain/entities/vehicle.features.dart';
import 'package:drivn/features/vehicle/domain/entities/vehicle.type.dart';

import '../../../../shared/utils/constants/baseUrl.dart';
import 'package:http/http.dart' as http;

class VehicleApiService {
  Future<List<VType>> fetchTypes() async {
    final uri = Uri.parse('$baseUrl/vehicle/types');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return vehicleTypeFromJson(response.body).data.data;
      } else {
        print('type status: ${response.statusCode} ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      print('Error while fetching features: $e');
      throw Exception('Failed to fetch types');
    }
  }

  Future<List<Feature>> fetchFeatures() async {
    final uri = Uri.parse('$baseUrl/vehicle/features');
    http.Response? response;
    try {
      response = await http.get(uri);
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
    final uri = Uri.parse('$baseUrl/vehicle/brands');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return vehicleBrandsFromJson(response.body).data.data;
      } else {
        print('brand status: ${response.statusCode} ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      print('Error while fetching features: $e');
      throw Exception('Failed to fetch brands');
    }
  }
}
