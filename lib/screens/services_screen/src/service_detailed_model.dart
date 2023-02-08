// To parse this JSON data, do
//
//     final addServiceModel = addServiceModelFromJson(jsonString);

import 'dart:convert';

List<ServiceDetailedModel> addServiceModelFromJson(String str) =>
    List<ServiceDetailedModel>.from(json.decode(str).map((x) => ServiceDetailedModel.fromJson(x)));

String addServiceModelToJson(List<ServiceDetailedModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceDetailedModel {
  ServiceDetailedModel(
      {required this.name,
      required this.contactPerson,
      required this.files,
      required this.commentary,
      required this.status,
      required this.publishDate,
      this.workerCommentary});
  DateTime publishDate;
  String name;
  ContactPerson contactPerson;
  List<String> files;
  String commentary;
  String? workerCommentary;
  int status;

  factory ServiceDetailedModel.fromJson(Map<String, dynamic> json) => ServiceDetailedModel(
      name: json["name"],
      contactPerson: ContactPerson.fromJson(json["contactPerson"]),
      files: List<String>.from(json["files"].map((x) => x)),
      commentary: json["commentary"],
      status: json["status"],
      publishDate: DateTime.parse(json["publishDate"]),
      workerCommentary: json["workerCommentary"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "publishDate": publishDate.toIso8601String(),
        "contactPerson": contactPerson.toJson(),
        "files": List<dynamic>.from(files.map((x) => x)),
        "commentary": commentary,
        "status": status,
        "workerCommentary": workerCommentary
      };
}

class ContactPerson {
  ContactPerson({
    required this.name,
    required this.phone,
  });

  String name;
  String phone;

  factory ContactPerson.fromJson(Map<String, dynamic> json) => ContactPerson(
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
      };
}
