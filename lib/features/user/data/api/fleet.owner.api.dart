import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/fleetOwner.model.dart';

class FleetOwnerAPI extends ChangeNotifier {
  FleetOwnerAPI();
  Future postFleetOwner(String requestBody) async {
    final Uri url = Uri.parse(
        'https://devapi.drivnapp.net/api/fleet-owners'); // Replace with your actual API URL

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final http.Response response = await http.post(
      url,
      headers: headers,
      body: requestBody,
    );

    if (response.statusCode == 200) {
      log(requestBody);

      // return
    } else {
      print('error:${response.reasonPhrase}');
      log(response.body.toString());
    }
  }

 Future verifyFleetOwner(String requestBody) async {
    final Uri url = Uri.parse(
        'https://devapi.drivnapp.net/api/fleet-owners/verify/$requestBody'); // Replace with your actual API URL

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final http.Response response = await http.post(
      url,
      headers: headers,
      body: null,
    );

    if (response.statusCode == 200) {
      log(requestBody);

      // return
    } else {
      print('error:${response.reasonPhrase}');
      log(response.body.toString());
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
