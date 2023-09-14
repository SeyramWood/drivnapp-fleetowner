// To parse this JSON data, do
//
//     final driverRequestModel = driverRequestModelFromJson(jsonString);

import 'dart:convert';

DriverRequestModel driverRequestModelFromJson(String str) =>
    DriverRequestModel.fromJson(json.decode(str));

String driverRequestModelToJson(DriverRequestModel data) =>
    json.encode(data.toJson());

class DriverRequestModel {
  Data? data;
  bool status;

  DriverRequestModel({
    this.data,
    required this.status,
  });

  factory DriverRequestModel.fromJson(Map<String, dynamic> json) =>
      DriverRequestModel(
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
  List<DRequest> data;

  Data({
    required this.count,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<DRequest>.from(
            json["data"]?.map((x) => DRequest.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DRequest {
  DateTime createdAt;
  String declineReason;
  Driver driver;
  int id;
  Rental rental;
  String status;
  DateTime updatedAt;
  Vehicle? vehicle;

  DRequest({
    required this.createdAt,
    required this.declineReason,
    required this.driver,
    required this.id,
    required this.rental,
    required this.status,
    required this.updatedAt,
    this.vehicle,
  });

  factory DRequest.fromJson(Map<String, dynamic> json) => DRequest(
        createdAt: DateTime.parse(json["createdAt"]),
        declineReason: json["declineReason"],
        driver: Driver.fromJson(json["driver"]),
        id: json["id"],
        rental: Rental.fromJson(json["rental"]),
        status: json["status"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        vehicle: Vehicle.fromJson(json["vehicle"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "declineReason": declineReason,
        "driver": driver.toJson(),
        "id": id,
        "rental": rental.toJson(),
        "status": status,
        "updatedAt": updatedAt.toIso8601String(),
        "vehicle": vehicle?.toJson(),
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

class Vehicle {
  String? availability;
  bool? booked;
  String? brand;
  List<Feature> features;
  String? moreFeatures;
  int? id;
  List<Image> images;
  String? type;

  Vehicle({
    required this.availability,
    required this.booked,
    required this.brand,
    required this.features,
    this.moreFeatures,
    required this.id,
    required this.images,
    required this.type,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        availability: json["availability"],
        booked: json["booked"],
        brand: json["brand"],
        features: List<Feature>.from(
            json["features"]?.map((x) => Feature.fromJson(x)) ?? []),
        moreFeatures: json["moreFeature"],
        id: json["id"],
        images: List<Image>.from(
            json["images"]?.map((x) => Image.fromJson(x)) ?? []),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "availability": availability,
        "booked": booked,
        "brand": brand,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "type": type,
      };
}

class Feature {
  int id;
  String info;
  String name;

  Feature({
    required this.id,
    required this.info,
    required this.name,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        info: json["info"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "info": info,
        "name": name,
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
