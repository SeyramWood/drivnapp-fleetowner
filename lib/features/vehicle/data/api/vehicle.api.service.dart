import 'dart:convert';
import 'dart:developer';

import 'package:drivn/features/vehicle/domain/entities/vehicle.brands.dart';
import 'package:drivn/features/vehicle/domain/entities/vehicle.features.dart';
import 'package:drivn/features/vehicle/domain/entities/vehicle.type.dart';

import '../../../../shared/utils/constants/baseUrl.dart';
import 'package:http/http.dart' as http;

class VehicleApiService {
//   List<Store> parseShop(String responseBody) {
//   final list = json.decode(responseBody) as List<dynamic>;
//   List<Store> shop = list.map((e) => Store.fromJson(e)).toList();
//   return shop;
// }
  Future fetchTypes() async {
    final uri = Uri.parse('$baseUrl/vehicle/types');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final vehicleType = vehicleTypeFromJson(response.body);
        List<String> typeNames =
            vehicleType.data.data.map((datum) => '${datum.name}.${datum.id}').toList();
        return typeNames;
      } else {
        print('type status: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future fetchFeatures() async {
    final uri = Uri.parse('$baseUrl/vehicle/features');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        var result = vehicleFeaturesFromJson(response.body);
        List<String> features = result.data.data.map((datum) =>'${datum.name}.${datum.id}',).toList();
        return features;
      } else {
        print(
            'feature status: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future fetchBrands() async {
    final uri = Uri.parse('$baseUrl/vehicle/brands');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final vehicleBrands = vehicleBrandsFromJson(response.body);
        var  brandsNames = vehicleBrands.data.data
            .map((datum) => '${datum.name}.${datum.id}')
            .toList();
        return brandsNames;
      } else {
        print('brand status: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      print(e);
    }
  }
}
