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

class UserApiService extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _user = '';
  get userId => _user;

  bool _accTypeIsOwner = true;
  bool get accTypeIsOwner => _accTypeIsOwner;
  isOwner(bool isOwner) {
    _accTypeIsOwner = isOwner;
    notifyListeners();
  }

  String docField = '';
  setDocField(field) {
    docField = field;
    notifyListeners();
    print(docField);
  }

  Future<void> setUserId(String id) async {
    final prefs = SharedPreferencesManager.instance;
    await prefs
        .setString(
      'userID',
      id,
    )
        .whenComplete(
      () {
        String? storedUserID = prefs.getString('userID', '');
        if (storedUserID.isNotEmpty) {
          _user = storedUserID;
          notifyListeners();
          print('set $_user');
        }
      },
    ); // Store the user ID in SharedPreferences
    notifyListeners();
  }

  //for the owner usage
  String _path = '';
  String get path => _path;
  set path(path) {
    _path = path;
  }

  String _field = '';
  String get field => _field;
  set field(field) {
    _field = field;
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

  Future verifyUser(String otp) async {
    try {
      final Uri url = Uri.parse(
          '$baseUrl/${_accTypeIsOwner ? 'fleet-owners' : 'drivers'}/verify/$otp');

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
        _accTypeIsOwner == false ? DriverApiService().onInit(id) : null;
        log(userId);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future logIn(String userId, String password) async {
    var url = Uri.parse(
        '$baseUrl/${_accTypeIsOwner ? 'fleet-owners' : 'drivers'}/$userId');
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
        _accTypeIsOwner == false ? DriverApiService().onInit(id) : null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Profile> fetchOwnerProfile(String iD) async {
    print(iD);
    final url = Uri.parse('$baseUrl/fleet-owners/$iD');
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        throw CustomException('Failed to get your profile');
      }
      print(response.body);

      final jsonBody = jsonDecode(response.body);
      return Profile.fromJson(jsonBody);
    } catch (e) {
      rethrow;
    }
  }

  Future<DProfile> fetchDriverProfile(String iD) async {
    print(iD);
    final url = Uri.parse('$baseUrl/drivers/$iD');
    try {
      final response = await http.get(url);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
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
  ) async {
    final url = Uri.parse('$baseUrl/fleet-owners/proof-identity/$_user');

    try {
      _isLoading = true;
      notifyListeners();
      if (files.isNotEmpty) {
        var request = http.MultipartRequest('POST', url);
        for (var file in files) {
          request.files.add(
            await http.MultipartFile.fromPath('idCard', file.path),
          );
        }
        var response = await request.send();
        if (response.statusCode != 201) {
          _isLoading = false;
          notifyListeners();
          throw CustomException('Operation failed');
        }
      } else {
        _isLoading = false;
        notifyListeners();
        throw CustomException('No file selected');
      }
    } catch (e) {
      return;
    }
  }

  Future submitId(
    List<File> files,
  ) async {
    final url = Uri.parse('$baseUrl/fleet-owners/drivers-document/$_user');
    print(_field);

    try {
      _isLoading = true;
      notifyListeners();
      if (files.isNotEmpty) {
        var request = http.MultipartRequest('POST', url);
        for (var file in files) {
          request.files.add(
            await http.MultipartFile.fromPath('documents', file.path),
          );
        }
        var response = await request.send();
        if (response.statusCode != 201) {
          _isLoading = false;
          notifyListeners();
          return CustomException('Operation failed');
        }
      } else {
        _isLoading = false;
        notifyListeners();
        return CustomException('No file selected');
      }
    } catch (e) {
      return;
    }
  }

  ///for the driver
  Future<void> submitData({required driver.Document docs
      // required List<File> idCardFiles,
      // required List<File> licenseFiles,
      // required String licenseNumber,
      // required String licenseType,
      // required int yearsOfExperience,
      // String? userID,
      // String? path,
      }) async {
    final uri = Uri.parse('$baseUrl/drivers/document/$_user');

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
        print(response.reasonPhrase);
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

  Future<void> updateUser(String id, String requestBody) async {
    final Uri uri = Uri.parse(
        '$baseUrl/${_accTypeIsOwner ? 'fleet-owners' : 'drivers'}/$id'); // Replace with your actual API URL

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
      print(e);
    }
  }
}
