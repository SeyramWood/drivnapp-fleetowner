import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:drivn/features/owner/domain/entities/available.vehicles.dart';
import 'package:drivn/features/vehicle/domain/entities/vehicle.features.dart';
import 'package:drivn/shared/errors/exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/utils/constants/baseUrl.dart';

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
        request.fields['feature[]'] = '$features';
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

        if (response.statusCode == 201) {
          print('Request successful');
          print(await response.stream.bytesToString());
        } else {
          throw CustomException(
              'Request failed with status code: ${response.statusCode}');
        }
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

  List<Vehicle> vehicles = [];
  Future<List<Vehicle>> fetchVehicles(String userID) async {
    final uri = Uri.parse('$baseUrl/vehicles/owner/$userID');
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      print(
        '${response.statusCode}\n${response.reasonPhrase}\n${response.body}',
      );
    }
    return vehiclesFromJson(response.body).data.data;
  }

  Future fetchBookedVehicles(String userID) async {
    final uri = Uri.parse('$baseUrl/bookings/owner/$userID');
    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        print(response.statusCode);
      }
      log(response.body);
    } catch (e) {
      print(e);
    }
  }
}
