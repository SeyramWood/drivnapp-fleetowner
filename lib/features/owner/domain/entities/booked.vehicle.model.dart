// To parse this JSON data, do
//
//     final bookedVehicle = bookedVehicleFromJson(jsonString);

import 'dart:convert';

BookedVehicle bookedVehicleFromJson(String str) =>
    BookedVehicle.fromJson(json.decode(str));

String bookedVehicleToJson(BookedVehicle data) => json.encode(data.toJson());

class BookedVehicle {
  Data? data;
  bool status;

  BookedVehicle({
    required this.data,
    required this.status,
  });

  factory BookedVehicle.fromJson(Map<String, dynamic> json) => BookedVehicle(
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
  List<BVehicle> data;

  Data({
    required this.count,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<BVehicle>.from(
            json["data"]?.map((x) => BVehicle.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BVehicle {
  String bookingStatus;
  DateTime createdAt;
  int id;
  String reference;
  Rental rental;
  String tripEndedAt;
  String tripStartedAt;
  String tripStatus;
  DateTime updatedAt;
  Vehicle vehicle;
  bool withDriver;

  BVehicle({
    required this.bookingStatus,
    required this.createdAt,
    required this.id,
    required this.reference,
    required this.rental,
    required this.tripEndedAt,
    required this.tripStartedAt,
    required this.tripStatus,
    required this.updatedAt,
    required this.vehicle,
    required this.withDriver,
  });

  factory BVehicle.fromJson(Map<String, dynamic> json) => BVehicle(
        bookingStatus: json["bookingStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        reference: json["reference"],
        rental: Rental.fromJson(json["rental"]),
        tripEndedAt: json["tripEndedAt"],
        tripStartedAt: json["tripStartedAt"],
        tripStatus: json["tripStatus"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        vehicle: Vehicle.fromJson(json["vehicle"]),
        withDriver: json["withDriver"],
      );

  Map<String, dynamic> toJson() => {
        "bookingStatus": bookingStatus,
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "reference": reference,
        "rental": rental.toJson(),
        "tripEndedAt": tripEndedAt,
        "tripStartedAt": tripStartedAt,
        "tripStatus": tripStatus,
        "updatedAt": updatedAt.toIso8601String(),
        "vehicle": vehicle.toJson(),
        "withDriver": withDriver,
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
  int vehicleAmount;

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
  int id;
  List<Image> images;
  String moreFeature;
  Customer owner;
  String type;

  Vehicle({
    required this.availability,
    required this.booked,
    required this.brand,
    required this.features,
    required this.id,
    required this.images,
    required this.moreFeature,
    required this.owner,
    required this.type,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        availability: json["availability"],
        booked: json["booked"],
        brand: json["brand"],
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        moreFeature: json["moreFeature"],
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
        "moreFeature": moreFeature,
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
