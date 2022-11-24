// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  ErrorModel({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
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
    this.message,
    this.errorCode,
  });

  String? message;
  int? errorCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        errorCode: json["errorCode"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errorCode": errorCode,
      };
}
