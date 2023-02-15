import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:pocket_home/screens/reports_screen/src/rating_report_model.dart';
import 'package:pocket_home/screens/services_screen/src/service_detailed_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc() : super(PollsInitial()) {
    on<OnPdfViewEvent>(_onPdfViewEvent);
    on<GenerateReportEvent>(_onGenerateReport);
  }

  Future<void> _onPdfViewEvent(OnPdfViewEvent event, Emitter<ReportsState> emit) async {
    try {
      final test = await rootBundle.load('assets/poll.pdf');
      final file = File.fromRawPath(test.buffer.asUint8List(test.offsetInBytes, test.lengthInBytes));

      emit(OpenPdfState(test.buffer.asUint8List(test.offsetInBytes, test.lengthInBytes)));
    } catch (e) {}
  }

  Future<void> _onGenerateReport(GenerateReportEvent event, Emitter<ReportsState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      List<ServiceDetailedModel> model = [];
      List<RatingReportModel> rating = [];
      final modelFromPrefs = prefs.getString('servicesModels');

      if (modelFromPrefs != null) model = addServiceModelFromJson(modelFromPrefs);

      for (var element in model) {
        if (element.choosePerson != null && element.ratingValue != null) {
          rating.add(RatingReportModel(element.ratingValue!, element.publishDate, element.choosePerson!));
        }
      }
      emit(OnRatingGettedState(rating));
    } catch (e) {}
  }
}
