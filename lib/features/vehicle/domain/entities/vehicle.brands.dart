// To parse this JSON data, do
//
//     final vehicleBrands = vehicleBrandsFromJson(jsonString);

import 'dart:convert';

VehicleBrands vehicleBrandsFromJson(String str) => VehicleBrands.fromJson(json.decode(str));

String vehicleBrandsToJson(VehicleBrands data) => json.encode(data.toJson());

class VehicleBrands {
    Data data;
    bool status;

    VehicleBrands({
        required this.data,
        required this.status,
    });

    factory VehicleBrands.fromJson(Map<String, dynamic> json) => VehicleBrands(
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
    List<Brand> data;

    Data({
        required this.count,
        required this.data,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<Brand>.from(json["data"].map((x) => Brand.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Brand {
    int availableVehicles;
    DateTime createdAt;
    int id;
    String logo;
    String name;
    int unavailableVehicles;
    DateTime updatedAt;
    int vehicles;

    Brand({
        required this.availableVehicles,
        required this.createdAt,
        required this.id,
        required this.logo,
        required this.name,
        required this.unavailableVehicles,
        required this.updatedAt,
        required this.vehicles,
    });

    factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        availableVehicles: json["availableVehicles"],
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        logo: json["logo"],
        name: json["name"],
        unavailableVehicles: json["unavailableVehicles"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        vehicles: json["vehicles"],
    );

    Map<String, dynamic> toJson() => {
        "availableVehicles": availableVehicles,
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "logo": logo,
        "name": name,
        "unavailableVehicles": unavailableVehicles,
        "updatedAt": updatedAt.toIso8601String(),
        "vehicles": vehicles,
    };
}
