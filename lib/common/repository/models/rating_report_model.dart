import 'package:pocket_home/common/repository/models/worker_model.dart';

class RatingReportModel {
  final int rating;
  final DateTime date;
  final WorkerModel worker;

  RatingReportModel(this.rating, this.date, this.worker);
}
