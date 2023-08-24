import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

const String baseUrl = 'https://devapi.drivnapp.net/api';
final fleetOwner = {
  'lastName': 'Stephen',
  'firstName': 'Essoun',
  'username': '+233591787845',
  'password': 'mypassword',
  'confirmPassword': 'mypassword',
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final url = Uri.parse('$baseUrl/fleet-owners');
                http.Response? response;
                try {
                  response = await http.post(url,
                      headers: {'content-type': 'application/json'},
                      body: jsonEncode(fleetOwner));
                  if (response.statusCode == 200) {
                    log(response.body);
                  } else {
                    log('else:${response.reasonPhrase}');
                  }
                } catch (e) {
                  log('$e');
                }
              },
              child: const Text('Post Request'),
            ),
            ElevatedButton(
              onPressed: () async {
                final url = Uri.parse('$baseUrl/fleet-owners');
                http.Response? response;
                try {
                  response = await http.get(url);

                  if (response.statusCode == 200) {
                    log(response.body);
                  } else {
                    log('else:${response.reasonPhrase}');
                  }
                } catch (e) {
                  log('$e');
                }
              },
              child: const Text('Get Request'),
            ),
          ],
        )),
      ),
    );
  }
}
