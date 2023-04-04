part of 'news_bloc.dart';

abstract class NewsEvent {}

class OnNewsTabInit extends NewsEvent {
  final bool needUpdateHome;
  OnNewsTabInit(this.needUpdateHome);
}

class UpdatePollEvent extends NewsEvent {
  final int newsId;
  final int pollValue;

  UpdatePollEvent(this.newsId, this.pollValue);
}
