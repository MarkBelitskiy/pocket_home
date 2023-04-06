import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/repository/repository.dart';
import 'package:pocket_home/common/widgets/floating_button/floating_button_access_enums.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';

part 'floating_button_event.dart';
part 'floating_button_state.dart';

class FloatingButtonBloc extends Bloc<FloatingButtonEvent, FloatingButtonState> {
  final MainFloatingActionButton enumValue;
  final MyHousesBloc myHousesBloc;
  final Repository repository;
  HouseModel? currentHouse;
  late StreamSubscription myHousesSubscription;
  bool isManager = false;
  FloatingButtonBloc({required this.enumValue, required this.myHousesBloc, required this.repository})
      : super(FloatingButtonInitial()) {
    myHousesSubscription = myHousesBloc.stream.listen((myHousesBlocState) {
      if (myHousesBlocState is UpdateIsManagerState) {
        if (isManager != myHousesBlocState.isManager || currentHouse != myHousesBlocState.currentHouse) {
          isManager = myHousesBlocState.isManager;
          currentHouse = myHousesBlocState.currentHouse;
          add(OnFloatingButtonUpdateEvent());
        }
      }
    });

    on<FloatingButtonEvent>((event, emit) async {
      if (event is OnFloatingButtonUpdateEvent) {
        _onButtonUpdate(event, emit);
      }
      if (event is OnInitButtonEvent) {
        if (enumValue == MainFloatingActionButton.myHome) {
          emit(ShowButtonState(currentHouse));
        }
        if (enumValue != MainFloatingActionButton.myHome && enumValue != MainFloatingActionButton.services) {
          myHousesBloc.add(UpdateIsManagerValueToFloatingButtonEvent());
        }
      }
    });
  }

  @override
  Future<void> close() {
    myHousesSubscription.cancel();
    return super.close();
  }

  Future<void> _onButtonUpdate(OnFloatingButtonUpdateEvent event, Emitter<FloatingButtonState> emit) async {
    if (enumValue == MainFloatingActionButton.myHome) {
      emit(ShowButtonState(currentHouse));
    }
    if (enumValue == MainFloatingActionButton.services && currentHouse != null) {
      emit(ShowButtonState(currentHouse));
    }
    if ((enumValue == MainFloatingActionButton.news || enumValue == MainFloatingActionButton.workers) &&
        currentHouse != null) {
      emit(ShowButtonState(currentHouse));
    }
  }
}
