// To parse this JSON data, do
//
//     final driverMdel = driverMdelFromJson(jsonString);

import 'dart:convert';

DriverMdel driverMdelFromJson(String str) => DriverMdel.fromJson(json.decode(str));

String driverMdelToJson(DriverMdel data) => json.encode(data.toJson());

class DriverMdel {
    Data data;
    bool status;

    DriverMdel({
        required this.data,
        required this.status,
    });

    factory DriverMdel.fromJson(Map<String, dynamic> json) => DriverMdel(
        data: Data.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
    };
}

class Data {
    DateTime createdAt;
    DriverObject document;
    String firstName;
    int id;
    String lastName;
    String status;
    DateTime updatedAt;
    String username;

    Data({
        required this.createdAt,
        required this.document,
        required this.firstName,
        required this.id,
        required this.lastName,
        required this.status,
        required this.updatedAt,
        required this.username,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        createdAt: DateTime.parse(json["createdAt"]),
        document: DriverObject.fromJson(json["document"]),
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "document": document.toJson(),
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
        "status": status,
        "updatedAt": updatedAt.toIso8601String(),
        "username": username,
    };
}

class DriverObject {
    String cardStatus;
    DateTime createdAt;
    int experience;
    int id;
    List<String> idCard;
    List<String> license;
    String licenseNumber;
    String licenseStatus;
    String licenseType;
    int rate;
    DateTime updatedAt;

    DriverObject({
        required this.cardStatus,
        required this.createdAt,
        required this.experience,
        required this.id,
        required this.idCard,
        required this.license,
        required this.licenseNumber,
        required this.licenseStatus,
        required this.licenseType,
        required this.rate,
        required this.updatedAt,
    });

    factory DriverObject.fromJson(Map<String, dynamic> json) => DriverObject(
        cardStatus: json["cardStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        experience: json["experience"],
        id: json["id"],
        idCard: List<String>.from(json["idCard"].map((x) => x)),
        license: List<String>.from(json["license"].map((x) => x)),
        licenseNumber: json["licenseNumber"],
        licenseStatus: json["licenseStatus"],
        licenseType: json["licenseType"],
        rate: json["rate"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "cardStatus": cardStatus,
        "createdAt": createdAt.toIso8601String(),
        "experience": experience,
        "id": id,
        "idCard": List<dynamic>.from(idCard.map((x) => x)),
        "license": List<dynamic>.from(license.map((x) => x)),
        "licenseNumber": licenseNumber,
        "licenseStatus": licenseStatus,
        "licenseType": licenseType,
        "rate": rate,
        "updatedAt": updatedAt.toIso8601String(),
    };
}
