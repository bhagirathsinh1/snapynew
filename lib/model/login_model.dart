// To parse this JSON data, do
//
//     final loingModel = loingModelFromJson(jsonString);

import 'dart:convert';

LoingModel loingModelFromJson(String str) =>
    LoingModel.fromJson(json.decode(str));

String loingModelToJson(LoingModel data) => json.encode(data.toJson());

class LoingModel {
  LoingModel({
    required this.username,
    required this.password,
  });

  String username;
  String password;

  factory LoingModel.fromJson(Map<String, dynamic> json) => LoingModel(
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username == null ? null : username,
        "password": password == null ? null : password,
      };
}
