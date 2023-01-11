import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pocket_home/screens/news_screen/src/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<NewsModel> model = [];
  late SharedPreferences prefs;
  NewsBloc() : super(NewsInitial()) {
    on<OnNewsTabInit>(_onNewsTabInit);
    on<UpdatePollEvent>(_onPollUpdate);
  }
  Future<void> _onNewsTabInit(
      OnNewsTabInit event, Emitter<NewsState> emit) async {
    prefs = await SharedPreferences.getInstance();

    try {
      emit(NewsLoadingState(true));
      await Future.delayed(const Duration(seconds: 1));
      final modelFromPrefs = prefs.getString('newsModel');

      if (modelFromPrefs != null) model = newsModelFromJson(modelFromPrefs);

      emit(NewsLoadingState(false));
      emit(NewsLoadedState(model));
    } catch (e) {
      emit(NewsLoadingState(false));
      emit(NewsLoadedState([]));
    }
  }

  Future<void> _onPollUpdate(
      UpdatePollEvent event, Emitter<NewsState> emit) async {
    try {
      model[event.newsId].choosenPollValue = event.pollValue;
      await prefs.setString('newsModel', newsModelToJson(model));

      emit(NewsLoadedState(model));
    } catch (e) {
      emit(NewsLoadedState([]));
    }
  }
}
