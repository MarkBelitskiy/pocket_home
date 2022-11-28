part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class OnNewsTabInit extends NewsEvent {
  OnNewsTabInit();
}
