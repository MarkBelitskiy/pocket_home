part of 'add_news_bloc.dart';

@immutable
abstract class AddNewsEvent {}

class ChangeBodyEvent extends AddNewsEvent {
  final int bodyValue;

  ChangeBodyEvent(this.bodyValue);
}

class CreateNewsEvent extends AddNewsEvent {
  final String title;
  final String newsText;
  final String filePath;
  CreateNewsEvent(
      {required this.title, required this.newsText, required this.filePath});
}
