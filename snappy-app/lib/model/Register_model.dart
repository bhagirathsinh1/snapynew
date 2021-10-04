// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
  });

  String email;
  String password;
  String firstName;
  String lastName;
  String profilePicture;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        profilePicture:
            json["profile_picture"] == null ? null : json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "profile_picture": profilePicture == null ? null : profilePicture,
      };
}
