part of 'reports_bloc.dart';


abstract class ReportsEvent {}

class OnPdfViewEvent extends ReportsEvent {}

class GenerateReportEvent extends ReportsEvent {}

class GenerateBudgetReportEvent extends ReportsEvent {}
