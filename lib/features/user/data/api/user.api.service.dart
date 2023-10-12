import 'dart:convert';
import 'dart:io';

import 'package:drivn/features/driver/presentation/dependency.injection/bindings.dart';
import 'package:drivn/shared/errors/exception.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/interceptor/http.client.interceptor.dart';
import '../../../../shared/utils/constants/base.url.dart';
import '../../../../shared/utils/shared.prefs.manager.dart';
import '../../../driver/data/api/driver.api.service.dart';
import '../../domain/entities/driver.profile.model.dart' as driver;
import '../../domain/entities/driver.profile.model.dart';
import '../../domain/entities/owner.profile.model.dart';
import '../../domain/entities/user.signup.model.dart';

/*this class is specific to authenticating related APIs because I started the project initially as a single app but later I had to combine two different user app into one project leaving me to think but some of the namings I left is as it was.
*/
final httpClient = http.Client();

class UserApiService {
  final storage = getIt<FlutterSecureStorage>();
  final customClient = HttpClientWithInterceptor(httpClient);

  Future<void> postUser(SignUpBody requestBody, String accountType) async {
    try {
      final url = Uri.parse('$baseUrl/$accountType');

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

  Future verifyUser(String otp, String accountType) async {
    try {
      final url = Uri.parse('$baseUrl/$accountType/verify/$otp');

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
        accountType == 'drivers' ? DriverApiService().onInit(id) : null;
        return id;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future fetchSession() async {
    try {
      const url = '$baseUrl/auth/session';
      final response = await customClient.get(url);
      if (response.statusCode != 200) {
        throw CustomException('failed to get session');
      }
      final jsonID = jsonDecode(response.body)['data']['id'];
      return jsonID;
    } catch (e) {
      rethrow;
    }
  }

  Future logIn(String phoneNumber, String password) async {
    var url = Uri.parse('$baseUrl/auth/login');
    try {
      final body = {"username": phoneNumber, "password": password};
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
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
        final jsonData = jsonDecode(response.body);

        await storage.write(key: 'accessToken', value: jsonData['accessToken']);
        await storage.write(
            key: 'refreshToken', value: jsonData['refreshToken']);
        //fetch user session after successfull login
        //within the fetchSession is return user id
        final user = await fetchSession();
        return user.toString();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future logOut() async {
    try {
      await storage.deleteAll();
      await SharedPreferencesManager.instance.clearStorage();
    } catch (e) {
      rethrow;
    }
  }

////not in use at the moment
  Future refreshAccessToken(String token) async {
    const url = '$baseUrl/auth/refresh';
    try {
      final response = await customClient.post(
        url,
        headers: {'X-Refresh-Token': token},
      );
      if (response.statusCode != 200) {
        throw CustomException('Couldn\'t refresh token');
      }
      final accessToken = jsonDecode(response.body)['accessToken'];
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final accessToken = jsonData['accessToken'];
        final refreshToken = jsonData['refreshToken'];
        return '$accessToken/$refreshToken';
      }

      return accessToken;
    } catch (e) {
      rethrow;
    }
  }

  Future<Profile> fetchOwnerProfile(String iD) async {
    final url = '$baseUrl/fleet-owners/$iD';
    try {
      final response = await customClient.get(url);
      if (response.statusCode != 200) {
        throw CustomException('Failed to get your profile');
      }
      final jsonBody = jsonDecode(response.body);
      return Profile.fromJson(jsonBody);
    } catch (e) {
      rethrow;
    }
  }

  Future updateProfilePic(File avatar) async {
    final url = Uri.parse('$baseUrl/auth/user/update-avatar');
    try {
      final request = http.MultipartRequest('PUT', url);
      request.files
          .add(await http.MultipartFile.fromPath('avatar', avatar.path));
      final response =
          await customClient.sendMultipartRequest(request: request);
      if (response.statusCode != 200) {
        throw CustomException('Couldn\'t update picture');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<DProfile> fetchDriverProfile(String iD) async {
    final url = '$baseUrl/drivers/$iD';
    try {
      final response = await customClient.get(url);
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
    final url = '$baseUrl/fleet-owners/proof-identity/$userID';

    try {
      if (files.isNotEmpty) {
        var request = http.MultipartRequest('POST', Uri.parse(url));
        for (var file in files) {
          request.files.add(
            await http.MultipartFile.fromPath('idCard', file.path),
          );
        }
        var response = await customClient.sendMultipartRequest(
            files: request.files, request: request);
        if (response.statusCode != 201) {
          throw CustomException('Operation failed');
        }
        return response.reasonPhrase;
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
    final url = '$baseUrl/fleet-owners/drivers-document/$userID';

    try {
      if (files.isNotEmpty) {
        var request = http.MultipartRequest('POST', Uri.parse(url));
        for (var file in files) {
          request.files.add(
            await http.MultipartFile.fromPath('documents', file.path),
          );
        }
        var response = await customClient.sendMultipartRequest(
            files: request.files, request: request);
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
  Future submitData(String userID, driver.Document docs) async {
    final url = '$baseUrl/drivers/document/$userID';

    try {
      if (docs.idCard.isNotEmpty && docs.license.isNotEmpty) {
        var request = http.MultipartRequest('POST', Uri.parse(url));

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

        var response = await customClient.sendMultipartRequest(
            files: request.files, fields: request.fields, request: request);
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

  Future updateUser(
    String id,
    String requestBody,
    String accountType,
  ) async {
    final url = '$baseUrl/$accountType/$id';

    var body = {
      "lastName": requestBody.split('/')[1],
      "firstName": requestBody.split('/')[0]
    };
    try {
      final response = await customClient.put(url, body: body);

      if (response.statusCode != 200) {
        throw CustomException('Failed to update');
      }
    } catch (e) {
      rethrow;
    }
  }
}
