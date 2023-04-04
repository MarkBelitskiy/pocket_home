import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/repository/repository.dart';
import 'package:pocket_home/screens/login_screen/src/bloc/auth_bloc.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';
import 'package:pocket_home/screens/news_screen/src/news_model.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  List<NewsModel> model = [];
  final MyHousesBloc myHousesBloc;
  final Repository repository;
  HouseModel? currentHouse;
  UserModel? user;
  late StreamSubscription<AuthState> authSubscription;

  NewsBloc({required this.repository, required this.myHousesBloc}) : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      if (event is OnNewsTabInit) {
        _onNewsTabInit(event, emit);
      } else if (event is UpdatePollEvent) {
        _onPollUpdate(event, emit);
      }
    });

    myHousesBloc.stream.listen((myHousesBlocState) {
      if (myHousesBlocState is MyHousesLoadedState) {
        currentHouse = myHousesBlocState.currentHouse;
        add(OnNewsTabInit(false));
      }
    });
  }
  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }

  Future<void> _onNewsTabInit(OnNewsTabInit event, Emitter<NewsState> emit) async {
    emit(NewsLoadingState(true));
    if (event.needUpdateHome) {
      myHousesBloc.add(SaveHouseToPrefs());
    }
    model = currentHouse?.news ?? [];

    emit(NewsLoadingState(false));
    emit(NewsLoadedState(model, currentHouse));
  }

  Future<void> _onPollUpdate(UpdatePollEvent event, Emitter<NewsState> emit) async {
    model[event.newsId].choosenPollValue = event.pollValue;
    currentHouse!.news = model;
    myHousesBloc.add(SaveHouseToPrefs());

    emit(NewsLoadedState(model, currentHouse));
  }
}
