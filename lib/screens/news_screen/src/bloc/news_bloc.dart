import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pocket_home/screens/news_screen/src/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<OnNewsTabInit>(_onNewsTabInit);
  }
  Future<void> _onNewsTabInit(
      OnNewsTabInit event, Emitter<NewsState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      emit(NewsLoadingState(true));
      await Future.delayed(const Duration(seconds: 1));
      final model = newsModelFromJson(prefs.getString('newsModel').toString());
      emit(NewsLoadingState(false));
      emit(NewsLoadedState(model));
    } catch (e) {
      emit(NewsLoadingState(false));
      emit(NewsLoadedState(null));
    }
  }
}
