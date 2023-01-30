import 'dart:convert';

List<ServiceItemModel> newsModelFromJson(String str) =>
    List<ServiceItemModel>.from(json.decode(str).map((x) => ServiceItemModel.fromJson(x)));

String newsModelToJson(List<ServiceItemModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceItemModel {
  ServiceItemModel({
    required this.serviceNumber,
    required this.serviceName,
    required this.status,
    required this.publishDate,
    this.comment,
  });

  String serviceNumber;
  String serviceName;
  DateTime publishDate;
  int status;
  String? comment;

  factory ServiceItemModel.fromJson(Map<String, dynamic> json) => ServiceItemModel(
        serviceNumber: json["serviceNumber"],
        serviceName: json["serviceName"],
        comment: json["comment"] ?? '',
        status: json["status"],
        publishDate: DateTime.parse(json["publishDate"]),
      );

  Map<String, dynamic> toJson() => {
        "serviceNumber": serviceNumber,
        "serviceName": serviceName,
        "comment": comment,
        "status": status,
        "publishDate": publishDate.toIso8601String(),
      };
}
