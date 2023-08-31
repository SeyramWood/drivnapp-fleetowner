// To parse this JSON data, do
//
//     final availableVehicles = availableVehiclesFromJson(jsonString);

import 'dart:convert';

AvailableVehicles availableVehiclesFromJson(String str) => AvailableVehicles.fromJson(json.decode(str));

String availableVehiclesToJson(AvailableVehicles data) => json.encode(data.toJson());

class AvailableVehicles {
    Data data;
    bool status;

    AvailableVehicles({
        required this.data,
        required this.status,
    });

    factory AvailableVehicles.fromJson(Map<String, dynamic> json) => AvailableVehicles(
        data: Data.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
    };
}

class Data {
    String availability;
    bool booked;
    String brand;
    DateTime createdAt;
    List<Document> documents;
    List<Feature> features;
    int id;
    List<Image> images;
    Owner owner;
    String type;
    DateTime updatedAt;

    Data({
        required this.availability,
        required this.booked,
        required this.brand,
        required this.createdAt,
        required this.documents,
        required this.features,
        required this.id,
        required this.images,
        required this.owner,
        required this.type,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        availability: json["availability"],
        booked: json["booked"],
        brand: json["brand"],
        createdAt: DateTime.parse(json["createdAt"]),
        documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        owner: Owner.fromJson(json["owner"]),
        type: json["type"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        
        "brand": brand,
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "owner": owner.toJson(),
        "type": type,
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
