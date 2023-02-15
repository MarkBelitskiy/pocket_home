part of 'reports_bloc.dart';

@immutable
abstract class ReportsState {}

class PollsInitial extends ReportsState {}

class OpenPdfState extends ReportsState {
  final Uint8List pdfData;

  OpenPdfState(this.pdfData);
}

class OnRatingGettedState extends ReportsState {
  final List<RatingReportModel> list;

  OnRatingGettedState(this.list);
}
