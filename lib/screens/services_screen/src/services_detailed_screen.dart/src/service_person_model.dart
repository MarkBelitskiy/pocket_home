import 'dart:convert';

List<ServicePersonModel> servicePersonModelFromJson(String str) =>
    List<ServicePersonModel>.from(json.decode(str).map((x) => ServicePersonModel.fromJson(x)));

String servicePersonModelToJson(List<ServicePersonModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String? serviceSinglePersonToJson(ServicePersonModel? data) => data != null ? json.encode(data.toJson()) : null;
ServicePersonModel serviceSinglePersonFromJson(String data) {
  return ServicePersonModel.fromJson(json.decode(data));
}

class ServicePersonModel {
  ServicePersonModel({
    required this.name,
    required this.phone,
    required this.jobTitle,
    // required this.house,
  });

  String name;
  String phone;
  String jobTitle;
  // String house;

  factory ServicePersonModel.fromJson(Map<String, dynamic> json) => ServicePersonModel(
        name: json["name"],
        phone: json["phone"],
        jobTitle: json["jobTitle"],
        // house: json["house"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "jobTitle": jobTitle,
        // "house": house,
      };
}
