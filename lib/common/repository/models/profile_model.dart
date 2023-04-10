import 'dart:convert';

import 'package:pocket_home/common/repository/models/my_home_model.dart';

List<UserModel> usersModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String usersModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel(
      {required this.phone,
      required this.name,
      required this.photoPath,
      required this.password,
      required this.login,
      this.userHouses});

  String phone;
  String name;
  String? photoPath;
  String password;
  String login;
  List<HouseModel>? userHouses;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      phone: json["phone"],
      name: json["name"],
      photoPath: json["photoPath"],
      password: json["password"],
      login: json["login"],
      userHouses: json["userHouses"] != null ? houseModelFromJson(json["userHouses"]) : null);

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "name": name,
        "photoPath": photoPath,
        "password": password,
        "login": login,
        "userHouses": userHouses != null ? houseModelToJson(userHouses!) : null
      };
}
