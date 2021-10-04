// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.profilePicture,
      required this.membership,
      required this.accessToken,
      required this.id});

  String email;
  String firstName;
  String lastName;
  String profilePicture;
  bool membership;
  String accessToken;
  int id;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"] == null ? null : json["email"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        profilePicture:
            json["profilePicture"] == null ? null : json["profilePicture"],
        membership: json["membership"] == null ? null : json["membership"],
        accessToken: json["access_token"] == null ? null : json["access_token"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "profilePicture": profilePicture == null ? null : profilePicture,
        "membership": membership == null ? null : membership,
        "access_token": accessToken == null ? null : accessToken,
        "id": id == null ? null : id,
      };
}
