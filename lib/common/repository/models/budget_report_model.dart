import 'package:pocket_home/common/repository/models/worker_model.dart';

class BudgetReportModel {
  final int total;

  final List<WorkerModel> worker;

  final int totalFromMonth;
  BudgetReportModel(this.total, this.worker, this.totalFromMonth);
}
