// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.jwt,
  });

  String? jwt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        jwt: json["jwt"],
      );

  Map<String, dynamic> toJson() => {
        "jwt": jwt,
      };
}
