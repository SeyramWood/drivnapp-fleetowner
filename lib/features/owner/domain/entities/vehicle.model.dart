// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final vehicles = vehiclesFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:drivn/features/vehicle/domain/entities/vehicle.features.dart';

Vehicles vehicleFromJson(String str) => Vehicles.fromJson(json.decode(str));

class Vehicles {
  Data? data;
  bool status;

  Vehicles({
    this.data,
    required this.status,
  });

  factory Vehicles.fromJson(json) => Vehicles(
        data: Data.fromJson(json["data"] ?? {}),
        status: json["status"],
      );
}

class Data {
  int? count;
  List<Vehicle> data;

  Data({
    required this.count,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<Vehicle>.from(
            json["data"]?.map((x) => Vehicle.fromJson(x)) ?? []),
      );
}

class Vehicle {
  String availability;
  bool booked;
  String brand;
  DateTime createdAt;
  List<Document>? documents;
  int id;
  List<Image> images;
  Owner owner;
  String type;
  Insurance? insurance;
  DateTime updatedAt;
  List<Feature> features;
  String? moreFeatures;
  Rental? rental;
  String? registrationNumber;
  /*
    String availability;
    bool booked;
    String brand;
    DateTime createdAt;
    List<Feature> features;
    int id;
    List<Image> images;
    Insurance insurance;
    Owner owner;
    String registrationNumber;
    String type;
    DateTime updatedAt; */

  Vehicle({
    required this.availability,
    required this.booked,
    required this.brand,
    required this.createdAt,
    this.insurance,
    this.documents,
    required this.id,
    required this.images,
    required this.owner,
    required this.type,
    required this.updatedAt,
    required this.features,
    this.rental,
    this.moreFeatures,
    this.registrationNumber,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
      availability: json["availability"],
      booked: json["booked"],
      brand: json["brand"],
      createdAt: DateTime.parse(json["createdAt"]),
      insurance: Insurance.fromJson(json["insurance"] ?? {}),
      documents: List<Document>.from(
          json["documents"]?.map((x) => Document.fromJson(x)) ?? []),
      id: json["id"],
      images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      owner: Owner.fromJson(json["owner"]),
      type: json["type"] ?? '',
      updatedAt: DateTime.parse(json["updatedAt"]),
      features: json["features"] == null
          ? []
          : List<Feature>.from(
              json["features"]!.map((x) => Feature.fromJson(x))),
      moreFeatures: json["moreFeature"] ?? '',
      rental: json["rental"] == null ? null : Rental.fromJson(json["rental"]),
      registrationNumber: json['registrationNumber'] ?? '');
}

class Document {
  String document;
  int id;

  Document({
    required this.document,
    required this.id,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        document: json["document"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "document": document,
        "id": id,
      };
}

class Image {
  int id;
  String image;

  Image({
    required this.id,
    required this.image,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}

class Insurance {
  String approval;

  Insurance({
    required this.approval,
  });

  factory Insurance.fromJson(Map<String, dynamic> json) => Insurance(
        approval: json["approval"],
      );

  Map<String, dynamic> toJson() => {
        "approval": approval,
      };
}

class Owner {
  String firstName;
  int id;
  String lastName;

  Owner({
    required this.firstName,
    required this.id,
    required this.lastName,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
      };
}

class Rental {
  Owner? driver;
  int id;
  String location;
  int price;

  Rental({
    this.driver,
    required this.id,
    required this.location,
    required this.price,
  });

  factory Rental.fromJson(Map<String, dynamic> json) => Rental(
        driver: json["driver"] == null ? null : Owner.fromJson(json["driver"]),
        id: json["id"],
        location: json["location"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "driver": driver?.toJson(),
        "location": location,
        "price": price,
      };
}

class VehicleToDBModel {
  String userID;
  String brand;
  List<File> documents;
  List<File> images;
  String type;
  List<String> features;
  String? moreFeatures;
  String registrationNumber;
  VehicleToDBModel({
    required this.userID,
    required this.brand,
    required this.documents,
    required this.images,
    required this.type,
    required this.features,
    this.moreFeatures,
    required this.registrationNumber,
  });
  Map<String, dynamic> toJson() => {
        "brand": brand,
        "document": documents,
        "image": images,
        "owner": userID,
        "type": type,
        "feature": features,
        "moreFeature": moreFeatures,
        "registrationNumber": registrationNumber,
      };
}
