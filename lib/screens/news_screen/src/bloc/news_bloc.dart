import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/repository/repository.dart';
import 'package:pocket_home/common/repository/models/my_home_model.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';
import 'package:pocket_home/common/repository/models/news_model.dart';
import 'package:pocket_home/common/repository/models/profile_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<NewsModel> model = [];
  final MyHousesBloc myHousesBloc;
  final Repository repository;
  HouseModel? currentHouse;
  UserModel? user;
  late StreamSubscription<MyHousesState> myHousesSubscription;

  NewsBloc({required this.repository, required this.myHousesBloc}) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      if (event is OnNewsTabInit) {
        _onNewsTabInit(event, emit);
      }
      if (event is UpdatePollEvent) {
        _onPollUpdate(event, emit);
      }
      if (event is LoadEmptyScreenEvent) {
        emit(NewsLoadedState(
          [],
        ));
      }
    });

    myHousesSubscription = myHousesBloc.stream.listen((myHousesBlocState) {
      if (myHousesBlocState is MyHousesLoadedState) {
        if (myHousesBlocState.currentHouse != null) {
          currentHouse = myHousesBlocState.currentHouse;
          add(OnNewsTabInit(false));
        } else {
          add(LoadEmptyScreenEvent());
        }
      }
    });
  }
  @override
  Future<void> close() {
    myHousesSubscription.cancel();
    return super.close();
  }

  Future<void> _onNewsTabInit(OnNewsTabInit event, Emitter<NewsState> emit) async {
    emit(NewsLoadingState(true));
    if (event.needUpdateHome) {
      myHousesBloc.add(SaveHouseToPrefs());
    }
    model = currentHouse!.news ?? [];

    emit(NewsLoadingState(false));
    emit(NewsLoadedState(
      model,
    ));
  }

  Future<void> _onPollUpdate(UpdatePollEvent event, Emitter<NewsState> emit) async {
    model[event.newsId].choosenPollValue = event.pollValue;
    currentHouse!.news = model;
    myHousesBloc.add(SaveHouseToPrefs());

    emit(NewsLoadedState(
      model,
    ));
  }
}
