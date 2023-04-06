part of 'reports_bloc.dart';

abstract class ReportsEvent {}

class GenerateRatingReportEvent extends ReportsEvent {}

class GenerateBudgetReportEvent extends ReportsEvent {}

class GenerateBudgetIncomeReportEvent extends ReportsEvent {}

class OnInitReportsEvent extends ReportsEvent {}
