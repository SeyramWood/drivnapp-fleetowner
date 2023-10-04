import 'dart:convert';

import 'package:drivn/features/driver/presentation/dependency.injection/bindings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../errors/exception.dart';
import '../utils/constants/base.url.dart';

final storage = getIt<FlutterSecureStorage>();

class HttpClientWithInterceptor {
  final http.Client _inner;
  String? _accessToken; // Store the current access token

  HttpClientWithInterceptor(this._inner);

  Future<http.Response> post(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    //  interceptor logic before making the request
    headers ??= {};
    headers['Authorization'] = 'Bearer $_accessToken';
    body ??= {};

    final response =
        await _inner.post(Uri.parse(url), body: body, headers: headers);

    //  interceptor logic after receiving the response
    if (response.statusCode == 401) {
      print(response.body);
      try {
        _accessToken = await refreshAccessToken(); // Refresh the token
        // Retry the original request with the new token
        headers['Authorization'] = 'Bearer $_accessToken';
        return await _inner.get(Uri.parse(url), headers: headers);
      } catch (e) {
        rethrow; // Rethrow if token refresh fails
      }
    }

    return response;
  }

  Future<http.Response> get(String url, {Map<String, String>? headers}) async {
    //  interceptor logic before making the request
    headers ??= {};
    headers['Authorization'] = 'Bearer $_accessToken';

    final response = await _inner.get(Uri.parse(url), headers: headers);

    //  interceptor logic after receiving the response
    if (response.statusCode == 401) {
      print(response.statusCode);
      try {
        _accessToken = await refreshAccessToken(); // Refresh the token
        // Retry the original request with the new token
        headers['Authorization'] = 'Bearer $_accessToken';
        return await _inner.get(Uri.parse(url), headers: headers);
      } catch (e) {
        rethrow; // Rethrow if token refresh fails
      }
    }

    return response;
  }

  Future<http.Response> put(String url,
      {Map<String, String>? headers, dynamic body}) async {
    //  interceptor logic before making the request
    headers ??= {};
    headers['Authorization'] = 'Bearer $_accessToken';
    body ??= {};

    final response =
        await _inner.put(Uri.parse(url), body: body, headers: headers);

    //  interceptor logic after receiving the response
    if (response.statusCode == 401) {
      print(response.statusCode);

      try {
        _accessToken = await refreshAccessToken(); // Refresh the token
        // Retry the original request with the new token
        headers['Authorization'] = 'Bearer $_accessToken';
        return await _inner.put(Uri.parse(url), body: body, headers: headers);
      } catch (e) {
        rethrow; // Rethrow if token refresh fails
      }
    }

    return response;
  }

  Future<http.Response> delete(String url,
      {Map<String, String>? headers}) async {
    //  interceptor logic before making the request
    headers ??= {};
    headers['Authorization'] = 'Bearer $_accessToken';

    final response = await _inner.delete(Uri.parse(url), headers: headers);

    //  interceptor logic after receiving the response
    if (response.statusCode == 401) {
      try {
        _accessToken = await refreshAccessToken(); // Refresh the token
        // Retry the original request with the new token
        headers['Authorization'] = 'Bearer $_accessToken';
        return await _inner.get(Uri.parse(url), headers: headers);
      } catch (e) {
        rethrow; // Rethrow if token refresh fails
      }
    }

    return response;
  }

  Future<http.Response> sendMultipartRequest(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? fields,
    List<http.MultipartFile>? files,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      // Set the authorization header with the current access token (if available)
      headers ??= {};
      headers['Authorization'] = 'Bearer $_accessToken';

      // Add text fields to the request (if provided)
      if (fields != null) {
        request.fields.addAll(fields);
      }

      // Add files to the request (if provided)
      if (files != null) {
        for (var file in files) {
          request.files.add(file);
        }
      }
      print(files);
      final streamedResponse = await _inner.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 401) {
        try {
          _accessToken = await refreshAccessToken(); // Refresh the token
          // Retry the original request with the new token

          // Create a new request with the updated headers
          final newRequest = http.MultipartRequest('POST', Uri.parse(url));
          newRequest.headers['Authorization'] = 'Bearer $_accessToken';

          // Add the fields and files to the new request
          if (fields != null) {
            newRequest.fields.addAll(fields);
          }
          if (files != null) {
            for (var file in files) {
              newRequest.files.add(file);
            }
          }

          // Send the new request
          final newStreamedResponse = await _inner.send(newRequest);
          return await http.Response.fromStream(newStreamedResponse);
        } catch (e) {
          rethrow; // Rethrow if token refresh fails
        }
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

Future<String> refreshAccessToken() async {
  final url = Uri.parse('$baseUrl/auth/refresh');
  try {
    final token = await storage.read(
        key:
            'refreshToken'); //read or get the refresh token stored in the local db
    final response = await http.post(
      url,
      headers: {'X-Refresh-Token': token ?? ''},
    );
    if (response.statusCode != 200) {
      throw CustomException('Couldn\'t refresh token');
    }
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      await storage.write(key: 'accessToken', value: jsonData['accessToken']);
      await storage.write(key: 'refreshToken', value: jsonData['refreshToken']);
    }
    return jsonDecode(response.body)['accessToken'];
  } catch (e) {
    rethrow;
  }
}

//intialize one instance of the storage class
setStorageLocator() {
  getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());
}
