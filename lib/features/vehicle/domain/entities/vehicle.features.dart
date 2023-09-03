// To parse this JSON data, do
//
//     final vehicleFeatures = vehicleFeaturesFromJson(jsonString);

import 'dart:convert';

VehicleFeature vehicleFeatureFromJson(String str) =>
    VehicleFeature.fromJson(json.decode(str));

String vehicleFeaturesToJson(VehicleFeature data) => json.encode(data.toJson());

class VehicleFeature {
  Data data;
  bool status;

  VehicleFeature({
    required this.data,
    required this.status,
  });

  factory VehicleFeature.fromJson(Map<String, dynamic> json) => VehicleFeature(
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
  List<Feature> data;

  Data({
    required this.count,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<Feature>.from(json["data"].map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Feature {
  DateTime createdAt;
  int id;
  String info;
  String name;
  DateTime updatedAt;

  Feature({
    required this.createdAt,
    required this.id,
    required this.info,
    required this.name,
    required this.updatedAt,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        info: json["info"] ?? '',
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
