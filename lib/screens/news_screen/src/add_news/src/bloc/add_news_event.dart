part of 'add_news_bloc.dart';

abstract class AddNewsEvent {}

class ChangeBodyEvent extends AddNewsEvent {
  final int bodyValue;

  ChangeBodyEvent(this.bodyValue);
}

class CreateNewsEvent extends AddNewsEvent {
  final NewsModel model;
  CreateNewsEvent({required this.model});
}
