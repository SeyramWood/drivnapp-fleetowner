// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignUpBody {
  SignUpBody({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
    required this.confirmPassword,
  });
  final String lastName;
  final String firstName;
  final String username;
  final String password;
  final String confirmPassword;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastName': lastName,
      'firstName': firstName,
      'username': username,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  factory SignUpBody.fromMap(Map<String, dynamic> map) {
    return SignUpBody(
      lastName: map['lastName'] as String,
      firstName: map['firstName'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpBody.fromJson(String source) =>
      SignUpBody.fromMap(json.decode(source) as Map<String, dynamic>);
}
