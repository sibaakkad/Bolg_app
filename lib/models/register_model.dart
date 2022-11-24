// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    this.success,
    this.id,
    this.message,
    this.user,
    this.roles,
    this.jwt,
  });

  bool? success;
  int? id;
  String? message;
  User? user;
  List<String>? roles;
  String? jwt;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        success: json["success"],
        id: json["id"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        roles: List<String>.from(json["roles"].map((x) => x)),
        jwt: json["jwt"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "id": id,
        "message": message,
        "user": user!.toJson(),
        "roles": List<dynamic>.from(roles!.map((x) => x)),
        "jwt": jwt,
      };
}

class User {
  User({
    this.id,
    this.userLogin,
    this.userNicename,
    this.userEmail,
    this.userUrl,
    this.userRegistered,
    this.userActivationKey,
    this.userStatus,
    this.displayName,
  });

  String? id;
  String? userLogin;
  String? userNicename;
  String? userEmail;
  String? userUrl;
  DateTime? userRegistered;
  String? userActivationKey;
  String? userStatus;
  String? displayName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["ID"],
        userLogin: json["user_login"],
        userNicename: json["user_nicename"],
        userEmail: json["user_email"],
        userUrl: json["user_url"],
        userRegistered: DateTime.parse(json["user_registered"]),
        userActivationKey: json["user_activation_key"],
        userStatus: json["user_status"],
        displayName: json["display_name"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "user_login": userLogin,
        "user_nicename": userNicename,
        "user_email": userEmail,
        "user_url": userUrl,
        "user_registered": userRegistered!.toIso8601String(),
        "user_activation_key": userActivationKey,
        "user_status": userStatus,
        "display_name": displayName,
      };
}
