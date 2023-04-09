import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/repository/repository.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';
import 'package:pocket_home/screens/news_screen/src/bloc/news_bloc.dart';

import 'package:pocket_home/screens/news_screen/src/news_model.dart';

part 'add_news_event.dart';
part 'add_news_state.dart';

class AddNewsBloc extends Bloc<AddNewsEvent, AddNewsState> {
  final Repository repository;
  final HouseModel currentHouse;
  final NewsBloc newsBloc;
  AddNewsBloc({required this.repository, required this.currentHouse, required this.newsBloc})
      : super(AddNewsInitial()) {
    on<ChangeBodyEvent>(_changeBodyEvent);
    on<CreateNewsEvent>(_createNewsEvent);
  }

  Future<void> _changeBodyEvent(ChangeBodyEvent event, Emitter<AddNewsState> emit) async {
    if (event.bodyValue == 0) emit(NewsBodyState());

    if (event.bodyValue == 1) emit(PollsBodyState());
  }

  Future<void> _createNewsEvent(CreateNewsEvent event, Emitter<AddNewsState> emit) async {
    emit(LoadingState(true));
    List<NewsModel> news = currentHouse.news ?? [];
    news.add(event.model);
    currentHouse.news = news;
    if (event.model.pollAnswers == null) {
      try {
        final fileFromModel = File(event.model.filePath);
        await repository.newsRepo.addNewsToTelegramChat(
            newsMsg: event.model.newsText, newsTitle: event.model.newsTitle, file: fileFromModel);
      } catch (e) {
        if (kDebugMode) {
          print('NEWS_LOAD_TO_TELEGRAMM_ERROR: $e');
        }
        emit(LoadingState(false));
        return;
      }
    } else {
      try {
        await repository.newsRepo
            .addPollToTelegramChat(options: event.model.pollAnswers!, title: event.model.newsTitle);
      } catch (e) {
        if (kDebugMode) {
          print('POLLS_LOAD_TO_TELEGRAMM_ERROR: $e');
        }
        emit(LoadingState(false));
        return;
      }
    }
    newsBloc.add(OnNewsTabInit(true));
    emit(LoadingState(false));
    emit(NewsAddedSuccessState(event.model.pollAnswers != null));
  }
}
