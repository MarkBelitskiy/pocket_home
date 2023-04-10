import 'dart:convert';

List<WorkerModel> workerModelFromJson(String str) =>
    List<WorkerModel>.from(json.decode(str).map((x) => WorkerModel.fromJson(x)));

String workerModelToJson(List<WorkerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WorkerModel {
  WorkerModel({
    required this.jobTitle,
    required this.fullName,
    required this.phone,
    required this.sallary,
  });

  String jobTitle;
  String fullName;
  String phone;
  String sallary;

  factory WorkerModel.fromJson(Map<String, dynamic> json) => WorkerModel(
        jobTitle: json["jobTitle"] ?? '',
        fullName: json["fullName"] ?? '',
        phone: json["phone"] ?? '',
        sallary: json["sallary"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "jobTitle": jobTitle,
        "fullName": fullName,
        "phone": phone,
        "sallary": sallary,
      };
}
