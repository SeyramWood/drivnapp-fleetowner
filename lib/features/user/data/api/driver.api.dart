import 'dart:io';

import '../../../../shared/utils/constants/baseUrl.dart';
import 'package:http/http.dart' as http;

class DriverAPIService{
  DriverAPIService();

  
  Future<List<File>> submitIDs(List<File> files,
      {String? field, String? path}) async {
    final uri = Uri.parse(
        '$baseUrl/ path/userID');

    try {
      if (files.isNotEmpty) {
        var request = http.MultipartRequest('POST', uri);

        for (var file in files) {
          request.files.add(
            await http.MultipartFile.fromPath(field ?? 'idCard', file.path),
          );
        }

        var response = await request.send();

        if (response.statusCode == 200 || response.statusCode == 201) {
        } else {}
      } else {
        print('No files to upload');
      }

      return files; // Return the list of files after all files are uploaded
    } catch (e) {
      print('Error: $e');
      rethrow; // Re-throw the caught exception for better error propagation
    }
  }

}