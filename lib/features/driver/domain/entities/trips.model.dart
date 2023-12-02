// To parse this JSON data, do
//
//     final driverTripModel = driverTripModelFromJson(jsonString);

import 'dart:convert';

DriverTripModel driverTripModelFromJson(String str) =>
    DriverTripModel.fromJson(json.decode(str));

String driverTripModelToJson(DriverTripModel data) =>
    json.encode(data.toJson());

class DriverTripModel {
  Data? data;
  bool status;

  DriverTripModel({
     this.data,
    required this.status,
  });

  factory DriverTripModel.fromJson(Map<String, dynamic> json) =>
      DriverTripModel(
        data: Data.fromJson(json["data"]??{}),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
      };
}

class Data {
  int? count;
  List<DTrip> data;

  Data({
    required this.count,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<DTrip>.from(json["data"]?.map((x) => DTrip.fromJson(x))??[]),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DTrip {
  String bookingStatus;
  DateTime createdAt;
  Driver driver;
  int id;
  String reference;
  Rental rental;
  String tripEndedAt;
  String tripStartedAt;
  String tripStatus;
  DateTime updatedAt;
  bool withDriver;

  DTrip({
    required this.bookingStatus,
    required this.createdAt,
    required this.driver,
    required this.id,
    required this.reference,
    required this.rental,
    required this.tripEndedAt,
    required this.tripStartedAt,
    required this.tripStatus,
    required this.updatedAt,
    required this.withDriver,
  });

  factory DTrip.fromJson(Map<String, dynamic> json) => DTrip(
        bookingStatus: json["bookingStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        driver: Driver.fromJson(json["driver"]),
        id: json["id"],
        reference: json["reference"],
        rental: Rental.fromJson(json["rental"]),
        tripEndedAt: json["tripEndedAt"],
        tripStartedAt: json["tripStartedAt"],
        tripStatus: json["tripStatus"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        withDriver: json["withDriver"],
      );

  Map<String, dynamic> toJson() => {
        "bookingStatus": bookingStatus,
        "createdAt": createdAt.toIso8601String(),
        "driver": driver.toJson(),
        "id": id,
        "reference": reference,
        "rental": rental.toJson(),
        "tripEndedAt": tripEndedAt,
        "tripStartedAt": tripStartedAt,
        "tripStatus": tripStatus,
        "updatedAt": updatedAt.toIso8601String(),
        "withDriver": withDriver,
      };
}

class Driver {
  String firstName;
  int id;
  String lastName;
  String username;

  Driver({
    required this.firstName,
    required this.id,
    required this.lastName,
    required this.username,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
        "username": username,
      };
}

class Rental {
  Driver customer;
  String customerLocation;
  String customerLocationAudio;
  int driverAmount;
  String paymentStatus;
  DateTime pickupDate;
  DateTime pickupTime;
  DateTime returnDate;
  DateTime returnTime;

  Rental({
    required this.customer,
    required this.customerLocation,
    required this.customerLocationAudio,
    required this.driverAmount,
    required this.paymentStatus,
    required this.pickupDate,
    required this.pickupTime,
    required this.returnDate,
    required this.returnTime,
  });

  factory Rental.fromJson(Map<String, dynamic> json) => Rental(
        customer: Driver.fromJson(json["customer"]),
        customerLocation: json["customerLocation"],
        customerLocationAudio: json["customerLocationAudio"],
        driverAmount: json["driverAmount"],
        paymentStatus: json["paymentStatus"],
        pickupDate: DateTime.parse(json["pickupDate"]),
        pickupTime: DateTime.parse(json["pickupTime"]),
        returnDate: DateTime.parse(json["returnDate"]),
        returnTime: DateTime.parse(json["returnTime"]),
      );

  Map<String, dynamic> toJson() => {
        "customer": customer.toJson(),
        "customerLocation": customerLocation,
        "customerLocationAudio": customerLocationAudio,
        "driverAmount": driverAmount,
        "paymentStatus": paymentStatus,
        "pickupDate": pickupDate.toIso8601String(),
        "pickupTime": pickupTime.toIso8601String(),
        "returnDate": returnDate.toIso8601String(),
        "returnTime": returnTime.toIso8601String(),
      };
}
