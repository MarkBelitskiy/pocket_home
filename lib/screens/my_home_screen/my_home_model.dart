import 'dart:convert';

import 'package:pocket_home/common/widgets/main_app_bottom_sheet/search_item.dart';
import 'package:pocket_home/screens/news_screen/src/news_model.dart';
import 'package:pocket_home/screens/services_screen/src/service_detailed_model.dart';

import 'src/workers_screen/src/add_new_worker_screen.dart/src/worker_model.dart';

List<HouseModel> houseModelFromJson(String str) =>
    List<HouseModel>.from(json.decode(str).map((x) => HouseModel.fromJson(x)));

String houseModelToJson(List<HouseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HouseModel extends SearchItem {
  HouseModel(
      {required this.houseNumber,
      required this.houseAddress,
      required this.manager,
      this.workers,
      this.news,
      required this.budget,
      this.services})
      : super(name: '', address: houseAddress, phone: '', homeNumber: houseNumber, jobTitle: '');

  String houseNumber;
  String houseAddress;
  Budget budget;
  Manager manager;
  List<WorkerModel>? workers;
  List<NewsModel>? news;
  List<ServiceDetailedModel>? services;
  factory HouseModel.fromJson(Map<String, dynamic> json) => HouseModel(
      houseNumber: json["houseNumber"],
      houseAddress: json["houseAddress"],
      budget: Budget.fromJson(json["budget"]),
      manager: Manager.fromJson(json["manager"]),
      workers: json["workers"] != null ? workerModelFromJson(json["workers"]) : null,
      news: json["news"] != null ? newsModelFromJson(json["news"]) : null,
      services: json["services"] != null ? addServiceModelFromJson(json["services"]) : null);

  Map<String, dynamic> toJson() => {
        "houseNumber": houseNumber,
        "houseAddress": houseAddress,
        "manager": manager.toJson(),
        "workers": workers != null ? workerModelToJson(workers!) : null,
        "budget": budget.toJson(),
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

class Budget {
  final List<BudgetPayDataModel> budgetPaymentData;
  int budgetTotalSum;

  Budget({required this.budgetPaymentData, required this.budgetTotalSum});
  factory Budget.fromJson(Map<String, dynamic> json) => Budget(
        budgetPaymentData: budgetPayDataFromJson(json["budgetPaymentData"]),
        budgetTotalSum: json["budgetTotalSum"],
      );

  Map<String, dynamic> toJson() => {
        "budgetTotalSum": budgetTotalSum,
        "budgetPaymentData": budgetPayDataToJson(budgetPaymentData),
      };
}

List<BudgetPayDataModel> budgetPayDataFromJson(String str) =>
    List<BudgetPayDataModel>.from(json.decode(str).map((x) => BudgetPayDataModel.fromJson(x)));

String budgetPayDataToJson(List<BudgetPayDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BudgetPayDataModel {
  final DateTime paymentDate;
  final int paymentValue;
  final String paymentUserFullName;
  final String paymentUserPhone;

  BudgetPayDataModel(
      {required this.paymentDate,
      required this.paymentValue,
      required this.paymentUserFullName,
      required this.paymentUserPhone});
  factory BudgetPayDataModel.fromJson(Map<String, dynamic> json) => BudgetPayDataModel(
      paymentDate: DateTime.parse(json["paymentDate"] ?? DateTime.now().toString()),
      paymentValue: json["budgetTotalSum"] ?? 0,
      paymentUserFullName: json["paymentUserFullName"] ?? '',
      paymentUserPhone: json["paymentUserPhone"] ?? "");

  Map<String, dynamic> toJson() => {
        "paymentDate": paymentDate.toIso8601String(),
        "paymentValue": paymentValue,
        "paymentUserFullName": paymentUserFullName,
        "paymentUserPhone": paymentUserPhone
      };
}
