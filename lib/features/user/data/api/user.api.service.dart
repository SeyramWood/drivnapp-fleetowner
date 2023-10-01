import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:drivn/shared/errors/exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/utils/constants/base.url.dart';
import '../../../../shared/utils/shared.prefs.manager.dart';
import '../../../driver/data/api/driver.api.service.dart';
import '../../domain/entities/driver.profile.model.dart' as driver;
import '../../domain/entities/driver.profile.model.dart';
import '../../domain/entities/owner.profile.model.dart';
import '../../domain/entities/user.signup.model.dart';

/*this class is specific to authenticating related APIs because I started the project initially as a single app but later I had to combine two different user app into one project leaving me to think but some of the namings I left is as it was.
*/

class UserApiService {
  Future<void> setUserId(String id) async {
    final prefs = SharedPreferencesManager.instance;
    await prefs.setString(
      'userID',
      id,
    );
  }

  Future<void> postUser(SignUpBody requestBody, String accountType) async {
    try {
      Uri url = Uri.parse(
        '$baseUrl/$accountType',
      );
      print(url);

      Map<String, String> headers = {
        'content-type': 'application/json',
      };

     final response = await http.post(
        url,
        headers: headers,
        body: requestBody.toJson(),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
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

  Future verifyUser(String otp,String accountType)async {
    try {
      final Uri url = Uri.parse(
          '$baseUrl/$accountType/verify/$otp');

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      http.Response? response;

      response = await http.post(
        url,
        headers: headers,
      );
      if (response.statusCode != 201) {
        final errorMessage = jsonDecode(response.body)['error'] as String?;
        if (errorMessage != null) {
          throw CustomException(errorMessage);
        } else {
          throw CustomException('An error occurred');
        }
      }
      if (response.statusCode == 201) {
        String id = jsonDecode(response.body)['data']['id'].toString();
        log(id);
        await setUserId(id);
        accountType == 'drivers' ? DriverApiService().onInit(id) : null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future logIn(String userId, String password,String accountType) async {
    var url = Uri.parse(
        '$baseUrl/$accountType/$userId');
    try {
      final response = await http.get(url).timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          return Future.delayed(
            const Duration(seconds: 3),
            () => http.get(url),
          );
        },
      );
      if (response.statusCode != 200) {
        final errorMessage = jsonDecode(response.body)['error'] as String?;
        if (errorMessage != null) {
          throw CustomException(errorMessage);
        } else {
          throw CustomException('An error occurred');
        }
      }
      if (response.statusCode == 200) {
        String id = jsonDecode(response.body)['data']['id'].toString();
        await setUserId(id);
        accountType == 'drivers' ? DriverApiService().onInit(id) : null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Profile> fetchOwnerProfile(String iD) async {
    final url = Uri.parse('$baseUrl/fleet-owners/$iD');
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw CustomException('Failed to get your profile');
      }
      final jsonBody = jsonDecode(response.body);
      return Profile.fromJson(jsonBody);
    } catch (e) {
      rethrow;
    }
  }

  Future<DProfile> fetchDriverProfile(String iD) async {
    final url = Uri.parse('$baseUrl/drivers/$iD');
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw CustomException(
          'Failed to get your profile',
          statusCode: response.statusCode,
        );
      }
      final jsonBody = jsonDecode(response.body);
      return DProfile.fromJson(jsonBody);
    } catch (e) {
      rethrow;
    }
  }

  //for the fleet owner
  Future submitDoc(
    List<File> files,
    String userID,
  ) async {
    final url = Uri.parse('$baseUrl/fleet-owners/proof-identity/$userID');

    try {
      if (files.isNotEmpty) {
        var request = http.MultipartRequest('POST', url);
        for (var file in files) {
          request.files.add(
            await http.MultipartFile.fromPath('idCard', file.path),
          );
        }
        var response = await request.send();
        if (response.statusCode != 201) {
          throw CustomException('Operation failed');
        }
      } else {
        throw CustomException('No file selected');
      }
    } catch (e) {
      return;
    }
  }

  Future submitId(
    List<File> files,
    String userID,
  ) async {
    final url = Uri.parse('$baseUrl/fleet-owners/drivers-document/$userID');

    try {
      if (files.isNotEmpty) {
        var request = http.MultipartRequest('POST', url);
        for (var file in files) {
          request.files.add(
            await http.MultipartFile.fromPath('documents', file.path),
          );
        }
        var response = await request.send();
        if (response.statusCode != 201) {
          throw CustomException('Operation failed');
        }
      } else {
        throw CustomException('No file selected');
      }
    } catch (e) {
      rethrow;
    }
  }

  ///for the driver
  Future<void> submitData(String userID, driver.Document docs) async {
    final uri = Uri.parse('$baseUrl/drivers/document/$userID');

    try {
      if (docs.idCard.isNotEmpty && docs.license.isNotEmpty) {
        var request = http.MultipartRequest('POST', uri);

        // Add idCard files to the request
        for (var file in docs.idCard) {
          request.files.add(
            await http.MultipartFile.fromPath('idCard', file.path),
          );
        }

        // Add license files to the request
        for (var file in docs.license) {
          request.files.add(
            await http.MultipartFile.fromPath('license', file.path),
          );
        }

        // Add other fields to the request
        request.fields['licenseNumber'] = docs.licenseNumber;
        request.fields['licenseType'] = docs.licenseType;
        request.fields['experience'] = "${docs.experience}";
        request.fields['rate'] = "${docs.rate}";

        var response = await request.send();
        if (response.statusCode != 200) {
          throw CustomException('Failed to submit');
        }
      } else {
        throw CustomException('no files selected');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getFleetOwner(String id) async {
    final Uri url = Uri.parse('https://example.com/fleet-owners/$id');

    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw CustomException('Something went wrong');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(
      String id, String requestBody, String accountType) async {
    final Uri uri = Uri.parse('$baseUrl/$accountType/$id');

    var body = {
      "lastName": requestBody.split('/')[1],
      "firstName": requestBody.split('/')[0]
    };
    try {
      final response = await http.put(uri, body: body);
      if (response.statusCode != 200) {
        throw CustomException('Failed to update');
      }
    } catch (e) {
      rethrow;
    }
  }
}
