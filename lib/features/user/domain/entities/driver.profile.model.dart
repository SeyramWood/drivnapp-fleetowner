// To parse this JSON data, do
//
//     final dProfile = dProfileFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

DProfile dProfileFromJson(String str) => DProfile.fromJson(json.decode(str));

String dProfileToJson(DProfile data) => json.encode(data.toJson());

class DProfile {
  Data data;
  bool status;

  DProfile({
    required this.data,
    required this.status,
  });

  factory DProfile.fromJson(Map<String, dynamic> json) => DProfile(
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
  String? avatar;
  Document? document;
  String firstName;
  int id;
  String lastName;
  String status;
  DateTime updatedAt;
  String username;

  Data({
    required this.createdAt,
this.avatar,
    this.document,
    required this.firstName,
    required this.id,
    required this.lastName,
    required this.status,
    required this.updatedAt,
    required this.username,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        createdAt: DateTime.parse(json["createdAt"]),
        avatar: json['avatar']??'',
        document: Document.fromJson(json["document"] ?? {}),
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "document": document!.toJson(),
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
        "status": status,
        "updatedAt": updatedAt.toIso8601String(),
        "username": username,
      };
}

class Document {
  String? cardStatus;
  DateTime? createdAt;
  int experience;
  int? id;
  List<dynamic> idCard;
  List<dynamic> license;
  String licenseNumber;
  String? licenseStatus;
  String licenseType;
  int rate;
  DateTime? updatedAt;

  Document({
    this.cardStatus,
    this.createdAt,
    required this.experience,
    this.id,
    required this.idCard,
    required this.license,
    required this.licenseNumber,
    this.licenseStatus,
    required this.licenseType,
    required this.rate,
    this.updatedAt,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        cardStatus: json["cardStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        experience: json["experience"],
        id: json["id"],
        idCard: List<String>.from(json["idCard"].map((x) => x)),
        license: List<String>.from(json["license"]?.map((x) => x) ?? []),
        licenseNumber: json["licenseNumber"],
        licenseStatus: json["licenseStatus"],
        licenseType: json["licenseType"],
        rate: json["rate"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "experience": experience,
        "idCard": List<dynamic>.from(idCard.map((x) => x)),
        "license": List<dynamic>.from(license.map((x) => x)),
        "licenseNumber": licenseNumber,
        "licenseStatus": licenseStatus,
        "licenseType": licenseType,
        "rate": rate,
      };
}
