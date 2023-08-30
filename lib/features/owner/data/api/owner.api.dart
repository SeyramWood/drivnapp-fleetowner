import 'dart:developer';
import 'dart:io';

import 'package:drivn/shared/errors/exception.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/utils/constants/baseUrl.dart';

class OwnerApiService {
  Future<String?> submitData({
    required String userID,
    required String carBrand,
    required String carType,
    required List<File> imageFiles,
    required List<File> proofFiles,
    required List<String> feature,
    String? moreFeatures,
    String? path,
  }) async {
    final uri = Uri.parse('$baseUrl/vehicles');

    try {
      if (imageFiles.isNotEmpty && proofFiles.isNotEmpty) {
        var request = http.MultipartRequest('POST', uri);

        // Add fields to the request
        request.fields['owner'] = userID;
        request.fields['brand'] = carBrand;
        request.fields['type'] = carType;
        request.fields['feature'] = '$feature';
        request.fields['moreFeature'] = moreFeatures ?? '4x4';

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
        if (response.statusCode == 200) {
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
      throw CustomException(failure.message);
    } catch (e) {
      print('Error: $e');
      rethrow; // Re-throw the caught exception for better error propagation
    }
    return null;
  }

  Future fetchTypes() async {
    final uri = Uri.parse('$baseUrl/vehicle/types');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        log(response.body);
      } else {
        print(response.statusCode);
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
        log(response.body);
      } else {
        print(response.statusCode);
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
        log(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future fetchCars(String userID) async {
    final uri = Uri.parse('$baseUrl/vehicles/$userID');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        log(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}
