import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';

import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';
import 'package:pocket_home/screens/pdf_view/pdf_generate.dart';
import 'package:pocket_home/screens/pdf_view/pdf_reports_models.dart';
import 'package:pocket_home/screens/services_screen/src/service_detailed_model.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final MyHousesBloc myHousesBloc;
  late HouseModel currentHouse;
  late StreamSubscription<MyHousesState> myHousesSubscription;
  ReportsBloc(this.myHousesBloc) : super(PollsInitial()) {
    on<GenerateRatingReportEvent>(_onGenerateRatingReport);
    on<GenerateBudgetReportEvent>(_onGenerateBudgetReport);
    on<OnInitReportsEvent>(_onInitEvent);
    on<GenerateBudgetIncomeReportEvent>(_onGenerateBudgetIncomeReport);
    myHousesSubscription = myHousesBloc.stream.listen((myHousesBlocState) {
      if (myHousesBlocState is MyHousesLoadedState) {
        if (myHousesBlocState.currentHouse != null) {
          currentHouse = myHousesBlocState.currentHouse!;
          add(OnInitReportsEvent());
        }
      }
    });
  }
  @override
  Future<void> close() {
    myHousesSubscription.cancel();
    return super.close();
  }

  Future<void> _onInitEvent(OnInitReportsEvent event, Emitter<ReportsState> emit) async {
    emit(OnInitReportsState());
  }

  Future<void> _onGenerateRatingReport(GenerateRatingReportEvent event, Emitter<ReportsState> emit) async {
    List<ServiceDetailedModel> services =
        currentHouse.services!.where((element) => element.ratingValue != null).toList();
    if (services.isNotEmpty) {
      File? file = await ratingPdfGenerate(services
          .map((e) => ServicesRatingReport(
              servicesDate: e.publishDate,
              userName: e.contactPerson.name,
              workerName: e.choosePerson!.fullName,
              ratingValue: e.ratingValue!,
              serviceName: e.name))
          .toList());
      if (file != null) {
        emit(ShowGeneratedReportState(file.path));
      }
    }
  }

  Future<void> _onGenerateBudgetIncomeReport(GenerateBudgetIncomeReportEvent event, Emitter<ReportsState> emit) async {
    File? file = await monthIncomeToBudgetPdfGenerate(BudgetIncomeReport(
        currentHouse.budget.budgetTotalSum,
        currentHouse.budget.budgetPaymentData
            .map((e) => BudgetIncomeModel(e.paymentUserFullName, e.paymentValue, e.paymentDate))
            .toList()));
    if (file != null) {
      emit(ShowGeneratedReportState(file.path));
    }
  }

  Future<void> _onGenerateBudgetReport(GenerateBudgetReportEvent event, Emitter<ReportsState> emit) async {
    File? file = await monthBudgetPdfGenerate(BudgetOnMothReportModel(
      currentHouse.budget.budgetTotalSum,
      currentHouse.workers?.map((e) => BudgetPayoutModel(e.fullName, int.parse(e.sallary))).toList() ?? [],
      [BudgetPayoutModel('Побелка бордюров', 70000)],
      [BudgetPayoutModel('Подготовка к общему празднованию Наурыза', 50000)],
    ));
    if (file != null) {
      emit(ShowGeneratedReportState(file.path));
    }
  }
}
