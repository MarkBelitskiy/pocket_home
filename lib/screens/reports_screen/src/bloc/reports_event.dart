part of 'reports_bloc.dart';

@immutable
abstract class ReportsEvent {}

class OnPdfViewEvent extends ReportsEvent {}

class GenerateReportEvent extends ReportsEvent {}
