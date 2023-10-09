import 'dart:convert';
import 'dart:developer';
import 'package:drivn/features/owner/domain/entities/booked.vehicle.model.dart';
import 'package:drivn/features/owner/domain/entities/v.request.model.dart';
import 'package:drivn/features/owner/domain/entities/vehicle.model.dart' as v;
import 'package:drivn/shared/errors/exception.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/interceptor/http.client.interceptor.dart';
import '../../../../shared/utils/constants/base.url.dart';
import '../../../driver/presentation/dependency.injection/bindings.dart';
import '../../domain/entities/driver.model.dart';
import '../../domain/entities/update.rental.model.dart';

final httpClient = http.Client();

class OwnerApiService {
  final storage = getIt<FlutterSecureStorage>();
  final customClient = HttpClientWithInterceptor(httpClient);
  //add a vehicle
  Future addVehicle({required v.VehicleToDBModel vehicle}) async {
    const url = '$baseUrl/vehicles';

    try {
      if (vehicle.images.isNotEmpty && vehicle.documents.isNotEmpty) {
        var request = http.MultipartRequest('POST', Uri.parse(url));

        // Add fields to the request
        request.fields['owner'] = vehicle.userID;
        request.fields['brand'] = vehicle.brand;
        request.fields['type'] = vehicle.type;
        request.fields['feature'] = vehicle.features.join(',');
        request.fields['moreFeature'] = vehicle.moreFeatures ?? '';
        request.fields['registrationNumber'] = vehicle.registrationNumber;

        for (var file in vehicle.images) {
          request.files.add(
            await http.MultipartFile.fromPath('image', file.path),
          );
        }

        for (var file in vehicle.documents) {
          request.files.add(
            await http.MultipartFile.fromPath('document', file.path),
          );
        }
        // final response = await request.send();

        var response = await customClient.sendMultipartRequest(
            files: request.files, fields: request.fields, request: request);

        if (response.statusCode != 201) {
          throw CustomException("Couldn't create or add vehicle");
        }
      } else {
        throw CustomException('No files selected');
      }
    } catch (failure) {
      rethrow;
    }
  }

// http get request for vehicles belonging to a user
  Future<List<v.Vehicle>> fetchVehicles(String userID) async {
    final url = '$baseUrl/vehicles/owner/$userID';
    try {
      final response = await customClient.get(url);

      if (response.statusCode != 200) {
        if (response.statusCode == 404) {
          // Handle the 404 error for the vehicle fetch.
          print('Vehicle not found for user $userID');
        } else {
          // Handle other HTTP status codes here.
          print('HTTP Error: ${response.statusCode}');
        }
        throw CustomException('Request  failed');
      }

      return v.vehicleFromJson(response.body).data!.data;
    } catch (e) {
      rethrow;
    }
  }

  Future addVehicleImage(String vehicleID) async {
    final url = '$baseUrl/vehicles/images/$vehicleID';
    try {
      final response = await customClient.put(url);
      if (response.statusCode != 200) {
        throw CustomException('Failed to add image. Try again.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future addVehicleDocument(String documentID) async {
    final url = '$baseUrl/vehicles/images/$documentID';
    try {
      final response = await customClient.put(url);
      if (response.statusCode != 200) {
        throw CustomException('Failed to add image. Try again.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateVehicleImage(String imageID) async {
    final url = '$baseUrl/vehicles/images/$imageID';
    try {
      final response = await customClient.put(url);
      if (response.statusCode != 200) {
        throw CustomException('Failed to update image. Try again.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future deleteVehicleImage(String imageID) async {
    final url = '$baseUrl/vehicles/images/$imageID';
    try {
      final response = await customClient.delete(url);
      if (response.statusCode != 200) {
        print(response.reasonPhrase);
        throw CustomException('Failed to delete image. Try again.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateVehicleDocument(String documentID) async {
    final url = '$baseUrl/vehicles/document/$documentID';
    try {
      final response = await customClient.put(url);
      if (response.statusCode != 200) {
        throw CustomException('Failed to update document. Try again.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future deleteVehicleDocument(String documentID) async {
    final url = '$baseUrl/vehicles/document/$documentID';
    try {
      final response = await customClient.delete(url);
      if (response.statusCode != 200) {
        throw CustomException('Failed to delete document. Try again.');
      }
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<v.Vehicle>> streamVehicles(String userID) async* {
    final url = '$baseUrl/vehicles/owner/$userID';

    try {
      final response = await customClient.get(url);

      if (response.statusCode != 200) {
        throw CustomException('Request failed');
      }

      final streamedResponse = http.StreamedResponse(
          response.bodyBytes as Stream<List<int>>, response.statusCode);
      final responseBodyStream = streamedResponse.stream;
      final buffer = <int>[];

      await for (final chunk in responseBodyStream) {
        buffer.addAll(chunk);
      }

      final decodedResponse = utf8.decode(buffer);
      final vehicles = v.vehicleFromJson(decodedResponse).data!.data;

      yield vehicles;
    } catch (e) {
      yield []; // Yield an empty list or handle errors as needed
    }
  }

  Future addInsurance(String vehicleID) async {
    final url = Uri.parse('$baseUrl/vehicles/insurance/$vehicleID');
    try {
      final fileResult =
          await FilePicker.platform.pickFiles(allowMultiple: false);
      if (fileResult != null && fileResult.files.isNotEmpty) {
        final file = fileResult.files.first;
        final request = http.MultipartRequest('POST', url);
        request.files
            .add(await http.MultipartFile.fromPath('insurance', file.path!));
        final response =
            await customClient.sendMultipartRequest(request: request);
        if (response.statusCode != 201) {
          throw CustomException("Failed to add insurance. Try again.");
        }
      } else {
        throw CustomException('No file selected');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BookedVehicle>> fetchBookedVehicles(String userID) async {
    final url = '$baseUrl/bookings/owner/$userID';
    try {
      final response = await customClient.get(url);
      if (response.statusCode != 200) {
        throw CustomException("couldn't fetch vehicles");
      }
      return bookedVehicleModelFromJson(response.body).data!.data;
    } catch (e) {
      rethrow;
    }
  }

  Future updateRental(
      String vehicleID, UpdateRentalModel updateRentalModel) async {
    final url = '$baseUrl/vehicles/rental/$vehicleID';
    final body = updateRentalModel.updateRentalToJson();
    try {
      final response = await customClient.put(
        url,
        body: body,
      );
      log(response.statusCode.toString());

      if (response.statusCode != 200) {
        log(response.reasonPhrase.toString());

        throw CustomException("Rental couldn't be updated");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateAvailability(
    String vehicleID,
    String status,
  ) async {
    final url = '$baseUrl/vehicles/availability/$vehicleID?status=$status';

    try {
      final response = await customClient.put(url);
      if (response.statusCode != 200) {
        throw CustomException("Availability couldn't be updated");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Dryver>> fetchDrivers() async {
    const url = '$baseUrl/drivers?approved=true&assigned=false';
    try {
      final response = await customClient.get(url);
      if (response.statusCode != 200) {
        throw CustomException('failed to get drivers');
      }
      return DriverModel.fromJson(json.decode(response.body)).data?.data ?? [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<VRequest>> allRequests(String userID) async {
    final url = '$baseUrl/booking/requests/owner/$userID';
    try {
      final response = await customClient.get(url);

      if (response.statusCode != 200) {
        throw CustomException("couldn't fetch request");
      }
      return vehicleRequestModelFromJson(response.body).data!.data;
    } catch (e) {
      rethrow;
    }
  }

  Future acceptRequest(String requestID) async {
    final url = '$baseUrl/booking/requests/accept/$requestID';
    try {
      final body = {
        "requestType": "owner",
        "status": "accepted",
      };
      final response = await customClient.put(url, body: body);
      if (response.statusCode != 200) {
        throw CustomException('Request failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future cancelRequest(String requestID, String? reason) async {
    final url = '$baseUrl/booking/requests/accept/$requestID';
    final body = {
      "requestType": "owner",
      "status": "declined",
      'reason': reason
    };
    try {
      final response = await customClient.put(url, body: body);
      if (response.statusCode != 200) {
        throw CustomException('Operation failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future deleteVehicle(String vehicleID) async {
    final url = '$baseUrl/vehicles/$vehicleID';
    try {
      final response = await customClient.delete(url);
      if (response.statusCode != 200) {
        throw CustomException('Operation failed');
      }
    } catch (e) {
      rethrow;
    }
  }
}
