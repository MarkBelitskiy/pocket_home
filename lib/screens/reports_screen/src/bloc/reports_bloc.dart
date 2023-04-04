import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';
import 'package:pocket_home/screens/my_home_screen/src/workers_screen/src/add_new_worker_screen.dart/src/worker_model.dart';
import 'package:pocket_home/screens/reports_screen/src/budget_report_model.dart';
import 'package:pocket_home/screens/reports_screen/src/rating_report_model.dart';
import 'package:pocket_home/screens/services_screen/src/service_detailed_model.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final MyHousesBloc myHousesBloc;
  ReportsBloc(this.myHousesBloc) : super(PollsInitial()) {
    on<OnPdfViewEvent>(_onPdfViewEvent);
    on<GenerateReportEvent>(_onGenerateReport);
    on<GenerateBudgetReportEvent>(_onGenerateBudgetReport);
  }

  Future<void> _onPdfViewEvent(OnPdfViewEvent event, Emitter<ReportsState> emit) async {
    try {
      final test = await rootBundle.load('assets/poll.pdf');

      emit(OpenPdfState(test.buffer.asUint8List(test.offsetInBytes, test.lengthInBytes)));
    } catch (e) {}
  }

  Future<void> _onGenerateReport(GenerateReportEvent event, Emitter<ReportsState> emit) async {
    try {
      List<ServiceDetailedModel> model = myHousesBloc.currentHouse!.services!;
      List<RatingReportModel> rating = [];

      for (var element in model) {
        if (element.choosePerson != null && element.ratingValue != null) {
          rating.add(RatingReportModel(element.ratingValue!, element.publishDate, element.choosePerson!));
        }
      }
      emit(OnRatingGettedState(rating));
    } catch (e) {}
  }

  Future<void> _onGenerateBudgetReport(GenerateBudgetReportEvent event, Emitter<ReportsState> emit) async {
    // try {
    //   int totalToMonth = myHousesBloc.currentHouse!.budget;

    //   for (var element in myHousesBloc.currentHouse!.workers ?? <WorkerModel>[]) {
    //     totalToMonth -= int.parse(element.sallary);
    //   }
    //   BudgetReportModel model =
    //       BudgetReportModel(myHousesBloc.currentHouse!.budget, myHousesBloc.currentHouse!.workers ?? [], totalToMonth);

    //   emit(OnBudgetGeneratedState(model));
    // } catch (e) {}
  }
}
