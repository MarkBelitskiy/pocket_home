part of 'add_news_bloc.dart';

abstract class AddNewsState {}

class AddNewsInitial extends AddNewsState {}

class NewsBodyState extends AddNewsState {}

class PollsBodyState extends AddNewsState {}

class NewsAddedSuccessState extends AddNewsState {}

class LoadingState extends AddNewsState {
  final bool isLaoding;

  LoadingState(this.isLaoding);
}
