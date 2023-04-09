import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/repository/repository.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';
import 'package:pocket_home/screens/my_home_screen/src/workers_screen/src/add_new_worker_screen.dart/src/worker_model.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';

import '../service_detailed_model.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final MyHousesBloc myHousesBloc;
  final Repository repository;
  UserModel? userModel;
  HouseModel? currentHouse;
  late StreamSubscription<MyHousesState> myHousesSubscription;
  ServicesBloc({required this.repository, required this.myHousesBloc}) : super(ServicesInitial()) {
    myHousesSubscription = myHousesBloc.stream.listen((myHousesBlocState) {
      if (myHousesBlocState is MyHousesLoadedState) {
        currentHouse = myHousesBlocState.currentHouse;
        if (currentHouse != null) {
          add(InitEvent());
        }
      }
    });

    on<InitEvent>(_onInit);
    on<ChangeServiceValue>(_onChangeStatusEvent);
    on<DeclineServiceEvent>(_onDeclineEvent);
    on<SetRatingValueEvent>(_onSetRatingEvent);
    on<SetWorkerEvent>(_setWorkerEvent);
    on<ScreenUpdateEvent>(_updateScreenEvent);
  }
  @override
  Future<void> close() {
    myHousesSubscription.cancel();
    return super.close();
  }

  List<ServiceDetailedModel> activeModels = [];
  List<ServiceDetailedModel> historyModels = [];

  Future<void> _onInit(InitEvent event, Emitter<ServicesState> emit) async {
    try {
      activeModels.clear();
      historyModels.clear();

      emit(LoadingState(true));

      userModel = await repository.userRepo.getUser();

      if (currentHouse!.services?.isNotEmpty ?? false) {
        for (var element in currentHouse!.services!) {
          if (element.contactPerson.phone == userModel!.phone ||
              userModel!.phone == currentHouse!.manager.phone ||
              userModel!.phone == element.choosePerson?.phone) {
            if (element.status == 1 || element.status == 0) {
              activeModels.add(element);
            } else {
              historyModels.add(element);
            }
          }
        }
      }
      activeModels.sort((a, b) => a.publishDate.millisecondsSinceEpoch);
      historyModels.sort((a, b) => a.publishDate.millisecondsSinceEpoch);
      if (event.needSaveToPrefs ?? false) {
        myHousesBloc.add(SaveHouseToPrefs());
      }
      emit(LoadingState(false));
      emit(ServicesLoaded(activeModels, historyModels, currentHouse!, userModel!));
    } catch (e) {
      if (kDebugMode) {
        print('SERVICES_BLOC_ON_INIT_ERROR:$e');
      }
      emit(LoadingState(false));
    }
  }

  Future<void> _onChangeStatusEvent(ChangeServiceValue event, Emitter<ServicesState> emit) async {
    try {
      emit(LoadingState(true));

      activeModels[event.model].status = event.value;
      List<ServiceDetailedModel> model = [...activeModels, ...historyModels];

      currentHouse!.services!.clear();
      currentHouse!.services!.addAll(model);
      myHousesBloc.add(SaveHouseToPrefs());
      emit(LoadingState(false));
      emit(ServicesLoaded(activeModels, historyModels, currentHouse!, userModel!));
    } catch (e) {
      emit(LoadingState(false));
      emit(ServicesLoaded(activeModels, historyModels, currentHouse!, userModel!));
    }
  }

  Future<void> _onDeclineEvent(DeclineServiceEvent event, Emitter<ServicesState> emit) async {
    try {
      emit(LoadingState(true));

      activeModels[event.index].status = 2;
      activeModels[event.index].workerCommentary = event.reason;
      List<ServiceDetailedModel> model = [...activeModels, ...historyModels];
      historyModels.add(activeModels[event.index]);
      activeModels.removeAt(event.index);
      currentHouse!.services!.clear();
      currentHouse!.services!.addAll(model);
      myHousesBloc.add(SaveHouseToPrefs());
      emit(LoadingState(false));
    } catch (e) {
      emit(LoadingState(false));
      if (kDebugMode) {
        print('SERVICES_BLOC_ON_DECLINE_ERROR:$e');
      }
    }
  }

  Future<void> _onSetRatingEvent(SetRatingValueEvent event, Emitter<ServicesState> emit) async {
    try {
      emit(LoadingState(true));

      activeModels[event.item].status = 3;
      activeModels[event.item].ratingValue = event.rating;

      List<ServiceDetailedModel> model = [...activeModels, ...historyModels];

      historyModels.add(activeModels[event.item]);
      activeModels.removeAt(event.item);
      currentHouse!.services!.clear();
      currentHouse!.services!.addAll(model);
      myHousesBloc.add(SaveHouseToPrefs());
      emit(RatingSetToServiceState());
      emit(LoadingState(false));
      emit(ServicesLoaded(activeModels, historyModels, currentHouse!, userModel!));
    } catch (e) {
      emit(LoadingState(false));
      emit(ServicesLoaded(activeModels, historyModels, currentHouse!, userModel!));
    }
  }

  Future<void> _setWorkerEvent(SetWorkerEvent event, Emitter<ServicesState> emit) async {
    try {
      emit(LoadingState(true));

      activeModels[event.index].choosePerson = event.worker;

      List<ServiceDetailedModel> model = [...activeModels, ...historyModels];

      currentHouse!.services!.clear();
      currentHouse!.services!.addAll(model);

      emit(LoadingState(false));
      emit(ServicesLoaded(activeModels, historyModels, currentHouse!, userModel!));
    } catch (e) {
      emit(LoadingState(false));
      emit(ServicesLoaded(activeModels, historyModels, currentHouse!, userModel!));
    }
  }

  Future<void> _updateScreenEvent(ScreenUpdateEvent event, Emitter<ServicesState> emit) async {
    try {
      emit(ServicesLoaded(activeModels, historyModels, currentHouse!, userModel!));
    } catch (e) {
      emit(LoadingState(false));
      emit(ServicesLoaded(activeModels, historyModels, currentHouse!, userModel!));
    }
  }
}
