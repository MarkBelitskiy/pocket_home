import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/utils/preferences_utils.dart';
import 'package:pocket_home/screens/login_screen/src/bloc/auth_bloc.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';
import 'package:pocket_home/screens/my_home_screen/src/workers_screen/src/add_new_worker_screen.dart/src/worker_model.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service_detailed_model.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final MyHousesBloc myHousesBloc;
  final AuthBloc authBloc;
  UserModel? userModel;
  ServicesBloc({required this.authBloc, required this.myHousesBloc}) : super(ServicesInitial()) {
    // final authSubscription = authBloc.stream.listen((authState) {
    //   if (authState is UpdateUserDataState) {
    //     userModel = authState.user;
    //     add(InitEvent());
    //   }
    // });

    // @override
    // Future<void> close() {
    //   authSubscription.cancel();
    //   return super.close();
    // }

    on<InitEvent>(_onInit);
    on<ChangeServiceValue>(_onChangeStatusEvent);
    on<DeclineServiceEvent>(_onDeclineEvent);
    on<SetRatingValueEvent>(_onSetRatingEvent);
    on<SetWorkerEvent>(_setWorkerEvent);
    on<ScreenUpdateEvent>(_updateScreenEvent);
  }

  ///Модельки
  List<ServiceDetailedModel> activeModels = [];
  List<ServiceDetailedModel> historyModels = [];
  late UserModel currentUser;
  Future<void> _onInit(InitEvent event, Emitter<ServicesState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      activeModels.clear();
      historyModels.clear();

      emit(LoadingState(true));

      String? usersStringFromPrefs = prefs.getString(PreferencesUtils.usersKey);
      String? login = prefs.getString(PreferencesUtils.loginKey);

      List<UserModel> users = usersStringFromPrefs != null && usersStringFromPrefs.isNotEmpty
          ? usersModelFromJson(usersStringFromPrefs)
          : [];

      for (var i = 0; i < users.length; i++) {
        if (users[i].login == login) {
          currentUser = users[i];
        }
      }

      if (kDebugMode) {
        print('ERROR ${myHousesBloc.currentHouse?.services?.toString()}');
      }
      if (myHousesBloc.currentHouse?.services?.isNotEmpty ?? false) {
        for (var element in myHousesBloc.currentHouse!.services!) {
          if (element.contactPerson.phone == currentUser.phone ||
              currentUser.phone == myHousesBloc.currentHouse?.manager.phone ||
              currentUser.phone == element.choosePerson?.phone) {
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
      emit(LoadingState(false));
      emit(ServicesLoaded(
        activeModels,
        historyModels,
      ));
    } catch (e) {
      if (kDebugMode) {
        print('SERVICES_BLOC_ON_INIT_ERROR:$e');
      }
      emit(LoadingState(false));
      emit(ServicesLoaded(
        const [],
        const [],
      ));
    }
  }

  Future<void> _onChangeStatusEvent(ChangeServiceValue event, Emitter<ServicesState> emit) async {
    try {
      emit(LoadingState(true));

      activeModels[event.model].status = event.value;
      List<ServiceDetailedModel> model = [...activeModels, ...historyModels];

      myHousesBloc.currentHouse!.services!.clear();
      myHousesBloc.currentHouse!.services!.addAll(model);
      // myHousesBloc.add(SaveHouseToPrefs());
      emit(LoadingState(false));
      emit(ServicesLoaded(
        activeModels,
        historyModels,
      ));
    } catch (e) {
      emit(LoadingState(false));
      emit(ServicesLoaded(
        const [],
        const [],
      ));
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
      myHousesBloc.currentHouse!.services!.clear();
      myHousesBloc.currentHouse!.services!.addAll(model);
      // myHousesBloc.add(SaveHouseToPrefs());
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
      myHousesBloc.currentHouse!.services!.clear();
      myHousesBloc.currentHouse!.services!.addAll(model);
      // myHousesBloc.add(SaveHouseToPrefs());
      emit(RatingSetToServiceState());
      emit(LoadingState(false));
      emit(ServicesLoaded(
        activeModels,
        historyModels,
      ));
    } catch (e) {
      emit(LoadingState(false));
      emit(ServicesLoaded(
        const [],
        const [],
      ));
    }
  }

  Future<void> _setWorkerEvent(SetWorkerEvent event, Emitter<ServicesState> emit) async {
    try {
      emit(LoadingState(true));

      activeModels[event.index].choosePerson = event.worker;

      List<ServiceDetailedModel> model = [...activeModels, ...historyModels];

      myHousesBloc.currentHouse!.services!.clear();
      myHousesBloc.currentHouse!.services!.addAll(model);

      emit(LoadingState(false));
      emit(ServicesLoaded(
        activeModels,
        historyModels,
      ));
    } catch (e) {
      emit(LoadingState(false));
      emit(ServicesLoaded(
        const [],
        const [],
      ));
    }
  }

  Future<void> _updateScreenEvent(ScreenUpdateEvent event, Emitter<ServicesState> emit) async {
    try {
      emit(ServicesLoaded(
        activeModels,
        historyModels,
      ));
    } catch (e) {
      emit(LoadingState(false));
      emit(ServicesLoaded(
        const [],
        const [],
      ));
    }
  }
}
