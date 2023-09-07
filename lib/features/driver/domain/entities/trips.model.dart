// To parse this JSON data, do
//
//     final dvriverTrip = dvriverTripFromJson(jsonString);

import 'dart:convert';

DvriverTrip dvriverTripFromJson(String str) => DvriverTrip.fromJson(json.decode(str));

String dvriverTripToJson(DvriverTrip data) => json.encode(data.toJson());

class DvriverTrip {
    Data? data;
    bool status;

    DvriverTrip({
        required this.data,
        required this.status,
    });

    factory DvriverTrip.fromJson(Map<String, dynamic> json) => DvriverTrip(
        data: Data.fromJson(json["data"]??{}),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "status": status,
    };
}

class Data {
    int? count;
    List<DTrip> data;

    Data({
         this.count,
        required this.data,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
        data: List<DTrip>.from(json["data"]?.map((x) => DTrip.fromJson(x))??[]),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DTrip {
    String bookingStatus;
    DateTime createdAt;
    Driver driver;
    int id;
    String reference;
    Rental rental;
    String tripEndedAt;
    String tripStartedAt;
    String tripStatus;
    DateTime updatedAt;
    Vehicle vehicle;
    bool withDriver;

    DTrip({
        required this.bookingStatus,
        required this.createdAt,
        required this.driver,
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

    factory DTrip.fromJson(Map<String, dynamic> json) => DTrip(
        bookingStatus: json["bookingStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        driver: Driver.fromJson(json["driver"]),
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
        "driver": driver.toJson(),
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

class Driver {
    String firstName;
    int id;
    String lastName;
    String username;

    Driver({
        required this.firstName,
        required this.id,
        required this.lastName,
        required this.username,
    });

    factory Driver.fromJson(Map<String, dynamic> json) => Driver(
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

class Rental {
    Driver customer;
    String customerLocation;
    String customerLocationAudio;
    int driverAmount;
    String paymentStatus;
    DateTime pickupDate;
    DateTime pickupTime;
    DateTime returnDate;
    DateTime returnTime;

    Rental({
        required this.customer,
        required this.customerLocation,
        required this.customerLocationAudio,
        required this.driverAmount,
        required this.paymentStatus,
        required this.pickupDate,
        required this.pickupTime,
        required this.returnDate,
        required this.returnTime,
    });

    factory Rental.fromJson(Map<String, dynamic> json) => Rental(
        customer: Driver.fromJson(json["customer"]),
        customerLocation: json["customerLocation"],
        customerLocationAudio: json["customerLocationAudio"],
        driverAmount: json["driverAmount"],
        paymentStatus: json["paymentStatus"],
        pickupDate: DateTime.parse(json["pickupDate"]),
        pickupTime: DateTime.parse(json["pickupTime"]),
        returnDate: DateTime.parse(json["returnDate"]),
        returnTime: DateTime.parse(json["returnTime"]),
    );

    Map<String, dynamic> toJson() => {
        "customer": customer.toJson(),
        "customerLocation": customerLocation,
        "customerLocationAudio": customerLocationAudio,
        "driverAmount": driverAmount,
        "paymentStatus": paymentStatus,
        "pickupDate": pickupDate.toIso8601String(),
        "pickupTime": pickupTime.toIso8601String(),
        "returnDate": returnDate.toIso8601String(),
        "returnTime": returnTime.toIso8601String(),
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
    Driver owner;
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
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        moreFeature: json["moreFeature"],
        owner: Driver.fromJson(json["owner"]),
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
