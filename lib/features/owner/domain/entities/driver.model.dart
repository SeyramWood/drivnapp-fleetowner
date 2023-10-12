// To parse this JSON data, do
//
//     final driver = driverFromJson(jsonString);

import 'dart:convert';

DriverModel driverFromJson(String str) =>
    DriverModel.fromJson(json.decode(str));

String driverToJson(DriverModel data) => json.encode(data.toJson());

class DriverModel {
  Data? data;
  bool status;

  DriverModel({
    required this.data,
    required this.status,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
        data: Data.fromJson(json["data"] ?? {}),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
      };
}

class Data {
  int? count;
  List<Dryver> data;

  Data({
    required this.count,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<Dryver>.from(
            json["data"]?.map((x) => Dryver.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Dryver {
  DateTime createdAt;
  String firstName;
  int id;
  String lastName;
  DateTime updatedAt;
  String username;
  Dryver({
    required this.createdAt,
    required this.firstName,
    required this.id,
    required this.lastName,
    required this.updatedAt,
    required this.username,
  });

  factory Dryver.fromJson(Map<String, dynamic> json) => Dryver(
        createdAt: DateTime.parse(json["createdAt"]),
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
        "updatedAt": updatedAt.toIso8601String(),
        "username": username,
      };
}
