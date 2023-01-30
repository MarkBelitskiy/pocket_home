// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.phone,
    required this.name,
    this.photoPath,
    required this.password,
  });

  String phone;
  String name;
  String? photoPath;
  String password;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        phone: json["phone"],
        name: json["name"],
        photoPath: json["photoPath"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "name": name,
        "photoPath": photoPath,
        "password": password,
      };
}
