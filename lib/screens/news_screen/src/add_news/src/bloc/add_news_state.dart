part of 'add_news_bloc.dart';

@immutable
abstract class AddNewsState {}

class AddNewsInitial extends AddNewsState {}

class NewsBodyState extends AddNewsState {}

class PollsBodyState extends AddNewsState {}
