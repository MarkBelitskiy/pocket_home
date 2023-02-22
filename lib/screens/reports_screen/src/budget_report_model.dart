import 'package:pocket_home/screens/my_home_screen/src/workers_screen/src/add_new_worker_screen.dart/src/worker_model.dart';

class BudgetReportModel {
  final int total;

  final List<WorkerModel> worker;

  final int totalFromMonth;
  BudgetReportModel(this.total, this.worker, this.totalFromMonth);
}
