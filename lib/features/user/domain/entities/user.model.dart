// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FleetOwner {
  FleetOwner({
    required this.firstName,
    required this.secondName,
  });
  final String firstName;
  final String secondName;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'secondName': secondName,
    };
  }

  factory FleetOwner.fromMap(Map<String, dynamic> map) {
    return FleetOwner(
      firstName: map['firstName'] as String,
      secondName: map['secondName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FleetOwner.fromJson(String source) => FleetOwner.fromMap(json.decode(source) as Map<String, dynamic>);
}
