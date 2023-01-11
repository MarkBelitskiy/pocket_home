import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pocket_home/screens/news_screen/src/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_news_event.dart';
part 'add_news_state.dart';

class AddNewsBloc extends Bloc<AddNewsEvent, AddNewsState> {
  AddNewsBloc() : super(AddNewsInitial()) {
    on<AddNewsEvent>((event, emit) {
      if (event is ChangeBodyEvent) {
        _changeBodyEvent(event, emit);
      }
      if (event is CreateNewsEvent) {
        _createNewsEvent(event, emit);
      }
    });
  }

  Future<void> _changeBodyEvent(
      ChangeBodyEvent event, Emitter<AddNewsState> emit) async {
    if (event.bodyValue == 0) emit(NewsBodyState());

    if (event.bodyValue == 1) emit(PollsBodyState());
  }

  Future<void> _createNewsEvent(
      CreateNewsEvent event, Emitter<AddNewsState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    final prefsModel = prefs.getString('newsModel');
    List<NewsModel> modelFromPrefs = [];

    if (prefsModel != null) {
      modelFromPrefs = newsModelFromJson(prefsModel);
    }
    List<NewsModel> modelToPrefs = [event.model];
    modelToPrefs.addAll(modelFromPrefs);
    prefs.setString("newsModel", newsModelToJson(modelToPrefs));
    emit(NewsAddedSuccessState());
  }
}
