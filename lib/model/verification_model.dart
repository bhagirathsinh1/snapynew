// To parse this JSON data, do
//
//     final verificationModel = verificationModelFromJson(jsonString);

import 'dart:convert';

VerificationModel verificationModelFromJson(String str) =>
    VerificationModel.fromJson(json.decode(str));

String verificationModelToJson(VerificationModel data) =>
    json.encode(data.toJson());

class VerificationModel {
  VerificationModel({
    required this.email,
    required this.verificationCode,
  });

  String email;
  String verificationCode;

  factory VerificationModel.fromJson(Map<String, dynamic> json) =>
      VerificationModel(
        email: json["email"] == null ? null : json["email"],
        verificationCode: json["verification_code"] == null
            ? null
            : json["verification_code"],
      );

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "verification_code": verificationCode == null ? null : verificationCode,
      };
}
