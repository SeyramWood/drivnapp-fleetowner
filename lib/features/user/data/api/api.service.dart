import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:drivn/shared/errors/exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/utils/constants/baseUrl.dart';
import '../../domain/entities/user.signup.model.dart';

class APIService extends ChangeNotifier {
  APIService();

  bool _accTypeIsOwner = true;
  bool get accTypeIsOwner => _accTypeIsOwner;
  isOwner(bool isOwner) {
    _accTypeIsOwner = isOwner;
    notifyListeners();
    return isOwner;
  }

  String _userID = '';
  String get userID => _userID;
  //for the owner usage
  String _path = '';
  String get path => _path;
  setPath(path) {
    _path = path;
    notifyListeners();
  }

  String _field = '';
  String get field => _field;
  setfield(field) {
    _field = field;
    notifyListeners();
  }

  Future<void> postUser(SignUpBody requestBody) async {
    try {
      Uri url = Uri.parse(
        '$baseUrl/${_accTypeIsOwner ? 'fleet-owners' : 'drivers'}',
      );

      Map<String, String> headers = {
        'content-type': 'application/json',
      };

      http.Response? response;
      response = await http.post(
        url,
        headers: headers,
        body: requestBody.toJson(),
      );

      print(response.body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        print(response.statusCode);

        final errorsMap =
            jsonDecode(response.body)['errors'] as Map<String, dynamic>?;

        if (errorsMap != null) {
          final List<String> errorMessages = [];

          // Iterate over each key-value pair in the errorsMap
          errorsMap.forEach((key, value) {
            if (value is String && value.isNotEmpty) {
              errorMessages.add(value);
            }
          });

          if (errorMessages.isNotEmpty) {
            final errorMessage =
                errorMessages.join('\n\n'); // Join messages with line breaks
            throw CustomException(errorMessage);
          }
        }

        throw CustomException("An error occurred");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future verifyUser(String requestBody) async {
    try {
      final Uri url = Uri.parse(
          '$baseUrl/${_accTypeIsOwner ? 'fleet-owners' : 'drivers'}/verify/$requestBody');

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      http.Response? response;

      response = await http.post(
        url,
        headers: headers,
      );
      log(response.body);
      if (response.statusCode == 201) {
        _userID = jsonDecode(response.body)['data']['id'].toString();
        print(_userID);
      }
      if (response.statusCode != 201) {
        final errorMessage = jsonDecode(response.body)['error'] as String?;
        if (errorMessage != null) {
          throw CustomException('An error occurred');
        } else {
          throw CustomException('An error occurred');
        }
      }
    } catch (e) {
      rethrow;
    }
  }

//for the owner
  Future<List<File>> uploadFiles(
    List<File> files,
  ) async {
    final uri = Uri.parse('$baseUrl/fleet-owners/$path/$_userID');

    try {
      if (files.isNotEmpty) {
        var request = http.MultipartRequest('POST', uri);

        for (var file in files) {
          request.files.add(
            await http.MultipartFile.fromPath(field, file.path),
          );
        }

        var response = await request.send();
        print(response.reasonPhrase);
        if (response.statusCode == 200 || response.statusCode == 201) {
          // Handle success response if needed
        } else {
          // Handle error response if needed
        }
      } else {
        print('No files to upload');
      }

      return files; // Return the list of files after all files are uploaded
    } catch (e) {
      print('Error: $e');
      rethrow; // Re-throw the caught exception for better error propagation
    }
  }

  ///for the driver
  Future<void> submitData({
    required List<File> idCardFiles,
    required List<File> licenseFiles,
    required String licenseNumber,
    required String licenseType,
    required int yearsOfExperience,
    // String? userID,
    String? path,
  }) async {
    final uri = Uri.parse('$baseUrl/drivers/document/$_userID');

    try {
      if (idCardFiles.isNotEmpty && licenseFiles.isNotEmpty) {
        var request = http.MultipartRequest('POST', uri);
        print(idCardFiles);
        print(licenseFiles);
        // Add idCard files to the request
        for (var file in idCardFiles) {
          request.files.add(
            await http.MultipartFile.fromPath('idCard', file.path),
          );
        }

        // Add license files to the request
        for (var file in licenseFiles) {
          request.files.add(
            await http.MultipartFile.fromPath('license', file.path),
          );
        }

        // Add other fields to the request
        request.fields['licenseNumber'] = licenseNumber;
        // request.fields['licenseStatus'] = licenseStatus;
        request.fields['licenseType'] = licenseType;
        request.fields['experience'] = '$yearsOfExperience';

        var response = await request.send();
        print(response.reasonPhrase);
        // print(response.headers);
      } else {
        print('no files selected');
      }
    } catch (e) {
      print('Error: $e');
      rethrow; // Re-throw the caught exception for better error propagation
    }
  }

  Future<void> getFleetOwner(String id) async {
    final Uri uri = Uri.parse(
        'https://example.com/fleet-owners/$id'); // Replace with your actual API URL

    final Map<String, String> headers = {
      'User-Agent': 'Apidog/1.0.0 (https://apidog.com)',
    };

    final http.Request request = http.Request('GET', uri);
    request.headers.addAll(headers);

    final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> updateFleetOwner(String id, String requestBody) async {
    final Uri uri = Uri.parse(
        'https://example.com/fleet-owners/$id'); // Replace with your actual API URL

    final Map<String, String> headers = {
      'User-Agent': 'Apidog/1.0.0 (https://apidog.com)',
      'Content-Type': 'application/json',
    };

    final http.Request request = http.Request('PUT', uri);
    request.headers.addAll(headers);
    request.body = requestBody;

    final http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}