// To parse this JSON data, do
//
//     final vehicleRequestModel = vehicleRequestModelFromJson(jsonString);

import 'dart:convert';

VehicleRequestModel vehicleRequestModelFromJson(String str) =>
    VehicleRequestModel.fromJson(json.decode(str));

String vehicleRequestModelToJson(VehicleRequestModel data) =>
    json.encode(data.toJson());

class VehicleRequestModel {
  Data? data;
  bool status;

  VehicleRequestModel({
    this.data,
    required this.status,
  });

  factory VehicleRequestModel.fromJson(Map<String, dynamic> json) =>
      VehicleRequestModel(
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
  List<VRequest> data;

  Data({
    required this.count,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<VRequest>.from(
            json["data"]?.map((x) => VRequest.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class VRequest {
  DateTime createdAt;
  String declineReason;
  int id;
  Rental rental;
  String status;
  DateTime updatedAt;
  Vehicle vehicle;

  VRequest({
    required this.createdAt,
    required this.declineReason,
    required this.id,
    required this.rental,
    required this.status,
    required this.updatedAt,
    required this.vehicle,
  });

  factory VRequest.fromJson(Map<String, dynamic> json) => VRequest(
        createdAt: DateTime.parse(json["createdAt"]),
        declineReason: json["declineReason"],
        id: json["id"],
        rental: Rental.fromJson(json["rental"]),
        status: json["status"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        vehicle: Vehicle.fromJson(json["vehicle"]),
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "declineReason": declineReason,
        "id": id,
        "rental": rental.toJson(),
        "status": status,
        "updatedAt": updatedAt.toIso8601String(),
        "vehicle": vehicle.toJson(),
      };
}

class Rental {
  Customer customer;
  String customerLocation;
  String customerLocationAudio;
  String paymentStatus;
  DateTime pickupDate;
  DateTime pickupTime;
  DateTime returnDate;
  DateTime returnTime;
  num vehicleAmount;
  num? refundAmount;

  Rental({
    required this.customer,
    required this.customerLocation,
    required this.customerLocationAudio,
    required this.paymentStatus,
    required this.pickupDate,
    required this.pickupTime,
    required this.returnDate,
    required this.returnTime,
    required this.vehicleAmount,
    this.refundAmount,
  });

  factory Rental.fromJson(Map<String, dynamic> json) => Rental(
        customer: Customer.fromJson(json["customer"]),
        customerLocation: json["customerLocation"],
        customerLocationAudio: json["customerLocationAudio"],
        paymentStatus: json["paymentStatus"],
        pickupDate: DateTime.parse(json["pickupDate"]),
        pickupTime: DateTime.parse(json["pickupTime"]),
        returnDate: DateTime.parse(json["returnDate"]),
        returnTime: DateTime.parse(json["returnTime"]),
        vehicleAmount: json["vehicleAmount"],
        refundAmount: json["refundAmount"],
      );

  Map<String, dynamic> toJson() => {
        "customer": customer.toJson(),
        "customerLocation": customerLocation,
        "customerLocationAudio": customerLocationAudio,
        "paymentStatus": paymentStatus,
        "pickupDate": pickupDate.toIso8601String(),
        "pickupTime": pickupTime.toIso8601String(),
        "returnDate": returnDate.toIso8601String(),
        "returnTime": returnTime.toIso8601String(),
        "vehicleAmount": vehicleAmount,
      };
}

class Customer {
  String firstName;
  int id;
  String lastName;
  String username;

  Customer({
    required this.firstName,
    required this.id,
    required this.lastName,
    required this.username,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
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

class Vehicle {
  String availability;
  bool booked;
  String brand;
  List<Feature> features;
  String? moreFeatures;
  int id;
  List<VImage> images;
  Customer owner;
  String type;

  Vehicle({
    required this.availability,
    required this.booked,
    required this.brand,
    required this.features,
    this.moreFeatures,
    required this.id,
    required this.images,
    required this.owner,
    required this.type,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        availability: json["availability"],
        booked: json["booked"],
        brand: json["brand"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        moreFeatures: json["moreFeature"] ?? '',
        id: json["id"],
        images:
            List<VImage>.from(json["images"].map((x) => VImage.fromJson(x))),
        owner: Customer.fromJson(json["owner"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "availability": availability,
        "booked": booked,
        "brand": brand,
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "owner": owner.toJson(),
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

class VImage {
  int id;
  String image;

  VImage({
    required this.id,
    required this.image,
  });

  factory VImage.fromJson(Map<String, dynamic> json) => VImage(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
