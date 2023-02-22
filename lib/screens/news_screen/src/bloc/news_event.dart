part of 'news_bloc.dart';

abstract class NewsEvent {}

class OnNewsTabInit extends NewsEvent {
  OnNewsTabInit();
}

class UpdatePollEvent extends NewsEvent {
  final int newsId;
  final int pollValue;

  UpdatePollEvent(this.newsId, this.pollValue);
}
