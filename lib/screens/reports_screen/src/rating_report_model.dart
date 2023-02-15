import 'package:pocket_home/screens/services_screen/src/services_detailed_screen.dart/src/service_person_model.dart';

class RatingReportModel {
  final int rating;
  final DateTime date;
  final ServicePersonModel worker;

  RatingReportModel(this.rating, this.date, this.worker);
}
