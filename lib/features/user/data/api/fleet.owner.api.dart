import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/utils/constants/baseUrl.dart';
import '../../domain/entities/user.signup.model.dart';

class APIService extends ChangeNotifier {
  APIService();

  bool _accTypeIsOwner = true;
  bool get accTypeIsOwner => _accTypeIsOwner;
  void fleetOwner(bool isOwner) {
    _accTypeIsOwner = isOwner;
    notifyListeners();
  }

  String _userID = '';
  String get userID => _userID;
  // Future<void> postUser(SignUpBody requestBody) async {
  //   final url = Uri.parse('https://devapi.drivnapp.net/api/fleet-owners');
  //   final headers = {
  //     'Content-Type': 'application/json',
  //   };

  //   http.Response? response;
  //   try {
  //     response =
  //         await http.post(url, headers: headers, body: requestBody.toJson());
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print('success');
  //     }
  //   } on Exception catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<void> postUser(SignUpBody requestBody) async {
    try {
      final Uri url = Uri.parse(
        '$baseUrl/${_accTypeIsOwner ? 'fleet-owners' : 'drivers'}',
      );

      final Map<String, String> headers = {
        'content-type': 'application/json',
      };
      /*
    with how I made the post request, did I do anything wrong
     */
      http.Response? response;
      print('account creation');
      response = await http.post(
        url,
        headers: headers,
        body: requestBody.toJson(),
      );
      print('account creation done');

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('response body :${jsonEncode(response.body)}');
        // return await requestBody;
      } else {
        log('else 1 :${response.reasonPhrase}');
        log('else 2 :${response.body}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future verifyFleetOwner(String requestBody) async {
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('$requestBody => ${response.body}');
        final responseBody = response.body;
        log(requestBody);

        final jsonResponse = jsonDecode(responseBody) as Map<String, dynamic>;

        final data = jsonResponse['data'] as Map<String, dynamic>;

        // Access the 'id' field from the 'data' object
        final id = data['id'] as int?;

        log('Extracted ID: $id');
        _userID = '$id';
        notifyListeners();
        return '$id';
      } else {
        log('error 1 :${response.reasonPhrase}');
        log('error 2 :${response.body}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<http.MultipartFile>> submitIDs(
    List<http.MultipartFile> files,
  ) async {
    final url = Uri.parse('$baseUrl/proof-identity/$_userID');

    try {
      for (var file in files) {
        final request = http.MultipartRequest('POST', url);

        print('Uploading file: ${file.filename}');
        final response = await request.send();
        print('sending request');

        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseBody = await response.stream.bytesToString();
          print('Upload success: $responseBody');
        } else {
          print('Upload error: ${response.statusCode}');
        }
      }

      return files; // Return the list of files after all files are uploaded
    } catch (e) {
      print('Exception: $e');
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
