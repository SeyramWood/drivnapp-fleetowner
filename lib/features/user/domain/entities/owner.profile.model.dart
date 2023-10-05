// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
    Data data;
    bool status;

    Profile({
        required this.data,
        required this.status,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
    Document document;
    String firstName;
    int id;
    String lastName;
    DateTime updatedAt;
    String username;

    Data({
        required this.createdAt,
        required this.document,
        required this.firstName,
        required this.id,
        required this.lastName,
        required this.updatedAt,
        required this.username,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        createdAt: DateTime.parse(json["createdAt"]),
        document: Document.fromJson(json["document"]),
        firstName: json["firstName"],
        id: json["id"],
        lastName: json["lastName"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "document": document.toJson(),
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
        "updatedAt": updatedAt.toIso8601String(),
        "username": username,
    };
}

class Document {
    DateTime createdAt;
    int id;
    List<String> idCard;
    DateTime updatedAt;

    Document({
        required this.createdAt,
        required this.id,
        required this.idCard,
        required this.updatedAt,
    });

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        idCard: List<String>.from(json["idCard"].map((x) => x)??[]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "idCard": List<dynamic>.from(idCard.map((x) => x)),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
