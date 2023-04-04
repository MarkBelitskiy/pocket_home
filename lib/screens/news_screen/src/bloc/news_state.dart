part of 'news_bloc.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<NewsModel> newsModel;
  final HouseModel? currentHouse;
  NewsLoadedState(this.newsModel, this.currentHouse);
}

class NewsLoadingState extends NewsState {
  final bool isLoading;

  NewsLoadingState(this.isLoading);
}
