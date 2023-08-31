// To parse this JSON data, do
//
//     final vehicleFeatures = vehicleFeaturesFromJson(jsonString);

import 'dart:convert';

VehicleFeatures vehicleFeaturesFromJson(String str) => VehicleFeatures.fromJson(json.decode(str));

String vehicleFeaturesToJson(VehicleFeatures data) => json.encode(data.toJson());

class VehicleFeatures {
    Data data;
    bool status;

    VehicleFeatures({
        required this.data,
        required this.status,
    });

    factory VehicleFeatures.fromJson(Map<String, dynamic> json) => VehicleFeatures(
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
    List<Datum> data;

    Data({
        required this.count,
        required this.data,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    DateTime createdAt;
    int id;
    String info;
    String name;
    DateTime updatedAt;

    Datum({
        required this.createdAt,
        required this.id,
        required this.info,
        required this.name,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        info: json["info"],
        name: json["name"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "info": info,
        "name": name,
        "updatedAt": updatedAt.toIso8601String(),
    };
}
