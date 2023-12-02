// To parse this JSON data, do
//
//     final vehicleType = vehicleTypeFromJson(jsonString);

import 'dart:convert';

VehicleType vehicleTypeFromJson(String str) => VehicleType.fromJson(json.decode(str));

String vehicleTypeToJson(VehicleType data) => json.encode(data.toJson());

class VehicleType {
    Data data;
    bool status;

    VehicleType({
        required this.data,
        required this.status,
    });

    factory VehicleType.fromJson(Map<String, dynamic> json) => VehicleType(
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
    List<VType> data;

    Data({
        required this.count,
        required this.data,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<VType>.from(json["data"].map((x) => VType.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class VType {
    DateTime createdAt;
    int id;
    String name;
    DateTime updatedAt;

    VType({
        required this.createdAt,
        required this.id,
        required this.name,
        required this.updatedAt,
    });

    factory VType.fromJson(Map<String, dynamic> json) => VType(
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        name: json["name"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "name": name,
        "updatedAt": updatedAt.toIso8601String(),
    };
}
