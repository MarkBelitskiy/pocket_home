part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<NewsModel> newsModel;

  NewsLoadedState(this.newsModel);
}

class NewsLoadingState extends NewsState {
  final bool isLoading;

  NewsLoadingState(this.isLoading);
}
