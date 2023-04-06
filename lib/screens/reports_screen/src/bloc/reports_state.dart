part of 'reports_bloc.dart';

abstract class ReportsState {}

class PollsInitial extends ReportsState {}

class OnInitReportsState extends ReportsState {}

class ShowGeneratedReportState extends ReportsState {
  final String path;

  ShowGeneratedReportState(this.path);
}
