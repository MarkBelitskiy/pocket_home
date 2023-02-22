import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';
import 'package:pocket_home/screens/news_screen/src/news_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<NewsModel> model = [];
  final MyHousesBloc myHousesBloc;
  NewsBloc(this.myHousesBloc) : super(NewsInitial()) {
    on<OnNewsTabInit>(_onNewsTabInit);
    on<UpdatePollEvent>(_onPollUpdate);
  }
  Future<void> _onNewsTabInit(OnNewsTabInit event, Emitter<NewsState> emit) async {
    try {
      emit(NewsLoadingState(true));

      for (var i = 0; i < 5; i++) {
        if (myHousesBloc.currentHouse == null) {
          await Future.delayed(const Duration(seconds: 1));
        }
      }

      model = myHousesBloc.currentHouse!.news ?? [];

      emit(NewsLoadingState(false));
      emit(NewsLoadedState(model));
    } catch (e) {
      emit(NewsLoadingState(false));
      emit(NewsLoadedState([]));
    }
  }

  Future<void> _onPollUpdate(UpdatePollEvent event, Emitter<NewsState> emit) async {
    try {
      model[event.newsId].choosenPollValue = event.pollValue;
      myHousesBloc.currentHouse!.news = model;
      myHousesBloc.add(SaveHouseToPrefs());

      emit(NewsLoadedState(model));
    } catch (e) {
      emit(NewsLoadedState([]));
    }
  }
}
