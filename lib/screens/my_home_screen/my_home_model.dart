import 'dart:convert';

import 'package:pocket_home/screens/news_screen/src/news_model.dart';
import 'package:pocket_home/screens/services_screen/src/service_detailed_model.dart';

import 'src/workers_screen/src/add_new_worker_screen.dart/src/worker_model.dart';

List<HouseModel> houseModelFromJson(String str) =>
    List<HouseModel>.from(json.decode(str).map((x) => HouseModel.fromJson(x)));

String houseModelToJson(List<HouseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HouseModel {
  HouseModel(
      {required this.houseNumber,
      required this.houseAddress,
      required this.manager,
      this.workers,
      this.news,
      required this.budget,
      this.services});

  String houseNumber;
  String houseAddress;
  int budget;
  Manager manager;
  List<WorkerModel>? workers;
  List<NewsModel>? news;
  List<ServiceDetailedModel>? services;
  factory HouseModel.fromJson(Map<String, dynamic> json) => HouseModel(
      houseNumber: json["houseNumber"],
      houseAddress: json["houseAddress"],
      budget: json["budget"] ?? 700000,
      manager: Manager.fromJson(json["manager"]),
      workers: json["workers"] != null ? workerModelFromJson(json["workers"]) : null,
      news: json["news"] != null ? newsModelFromJson(json["news"]) : null,
      services: json["services"] != null ? addServiceModelFromJson(json["services"]) : null);

  Map<String, dynamic> toJson() => {
        "houseNumber": houseNumber,
        "houseAddress": houseAddress,
        "manager": manager.toJson(),
        "workers": workers != null ? workerModelToJson(workers!) : null,
        "budget": budget,
        "news": news != null ? newsModelToJson(news!) : null,
        "services": services != null ? addServiceModelToJson(services!) : null
      };
}

class Manager {
  Manager({
    required this.name,
    required this.phone,
  });

  String name;
  String phone;

  factory Manager.fromJson(Map<String, dynamic> json) => Manager(
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
      };
}
