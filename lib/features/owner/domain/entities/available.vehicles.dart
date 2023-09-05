// To parse this JSON data, do
//
//     final vehicles = vehiclesFromJson(jsonString);

import 'dart:convert';

Vehicles vehiclesFromJson(String str) => Vehicles.fromJson(json.decode(str));

String vehiclesToJson(Vehicles data) => json.encode(data.toJson());

class Vehicles {
  Data data;
  bool status;

  Vehicles({
    required this.data,
    required this.status,
  });

  factory Vehicles.fromJson(Map<String, dynamic> json) => Vehicles(
        data: Data.fromJson(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
      };
}

class Data {
  int count;
  List<Vehicle> data;

  Data({
    required this.count,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<Vehicle>.from(json["data"].map((x) => Vehicle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Vehicle {
  String availability;
  bool booked;
  String brand;
  DateTime createdAt;
  List<Document> documents;
  int id;
  List<Image> images;
  Owner owner;
  String type;
  DateTime updatedAt;
  List<Feature>? features;
  Rental? rental;

  Vehicle({
    required this.availability,
    required this.booked,
    required this.brand,
    required this.createdAt,
    required this.documents,
    required this.id,
    required this.images,
    required this.owner,
    required this.type,
    required this.updatedAt,
    this.features,
    this.rental,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        availability: json["availability"],
        booked: json["booked"],
        brand: json["brand"],
        createdAt: DateTime.parse(json["createdAt"]),
        documents: List<Document>.from(
            json["documents"].map((x) => Document.fromJson(x))),
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        owner: Owner.fromJson(json["owner"]),
        type: json["type"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        features: json["features"] == null
            ? []
            : List<Feature>.from(
                json["features"]!.map((x) => Feature.fromJson(x))),
        rental: json["rental"] == null ? null : Rental.fromJson(json["rental"]),
      );

  Map<String, dynamic> toJson() => {
        "availability": availability,
        "booked": booked,
        "brand": brand,
        "createdAt": createdAt.toIso8601String(),
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "owner": owner.toJson(),
        "type": type,
        "updatedAt": updatedAt.toIso8601String(),
        "features": features == null
            ? []
            : List<dynamic>.from(features!.map((x) => x.toJson())),
        "rental": rental?.toJson(),
      };
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

class Feature {
  int id;
  String info;
  String name;
  String slug;

  Feature({
    required this.id,
    required this.info,
    required this.name,
    required this.slug,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        info: json["info"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "info": info,
        "name": name,
        "slug": slug,
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
        firstName: json["firstName"] ,
        id: json["id"],
        lastName: json["lastName"] ,
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

//using owner as a driver because they both have same parameters
// class Driver {
//     int count;
//     List<Owner> data;

//     Driver({
//         required this.count,
//         required this.data,
//     });

//     factory Driver.fromJson(Map<String, dynamic> json) => Driver(
//         count: json["count"],
//         data: List<Owner>.from(json["data"].map((x) => Owner.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "count": count,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }