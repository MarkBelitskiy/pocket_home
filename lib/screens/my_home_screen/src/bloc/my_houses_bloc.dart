import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/utils/preferences_utils.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'my_houses_event.dart';
part 'my_houses_state.dart';

class MyHousesBloc extends Bloc<MyHousesEvent, MyHousesState> {
  MyHousesBloc() : super(MyHousesInitial()) {
    on<InitHousesEvent>(_onInit);
    on<GetHousesToModalEvent>(_onGetHousese);
    on<FilteredHousesToModalEvent>(_onFiltered);
    on<AddHouseToMyHouseseEvent>(_onAddHouse);
    on<FilteredHousesToChangeHouseModalEvent>(_onFilteredToChange);
    on<ChangeCurrentHomeEvent>(_onChangeCurrentActiveHouse);
    on<SaveHouseToPrefs>(_onSaveHouseToPrefs);
    on<ClearDataEvent>(_onClear);
  }

  List<HouseModel> _housesList = [
    HouseModel(
        houseNumber: '25',
        houseAddress: '7й микрорайон',
        budget: 700000,
        manager: Manager(name: 'Марк Белицкий', phone: '+7 700 726 4066')),
    HouseModel(
        houseNumber: '12',
        budget: 700000,
        houseAddress: '8й микрорайон',
        manager: Manager(name: 'Екатерина', phone: '+7 771 280 4163')),
    HouseModel(
        houseNumber: '230',
        budget: 700000,
        houseAddress: 'пр-кт. Абая',
        manager: Manager(name: 'Ольга Майер', phone: '+7 705 109 2994'))
  ];

  List<HouseModel> userHousesList = [];
  HouseModel? currentHouse;
  UserModel? currentUser;

  Future _onInit(InitHousesEvent event, Emitter<MyHousesState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      String? houses = prefs.getString(PreferencesUtils.housesKey);
      if (houses != null && houses.isNotEmpty) {
        _housesList = houseModelFromJson(houses);
      } else {
        prefs.setString(PreferencesUtils.housesKey, houseModelToJson(_housesList));
      }

      String? usersStringFromPrefs = prefs.getString(PreferencesUtils.usersKey);
      String? login = prefs.getString(PreferencesUtils.loginKey);

      List<UserModel> users = usersStringFromPrefs != null && usersStringFromPrefs.isNotEmpty
          ? usersModelFromJson(usersStringFromPrefs)
          : [];

      UserModel? user;

      for (var i = 0; i < users.length; i++) {
        if (users[i].login == login) {
          user = users[i];
        }
      }
      currentUser = user;
      userHousesList = user?.userHouses ?? [];
      if (user?.userHouses?.isNotEmpty ?? false) {
        for (var i = 0; i < user!.userHouses!.length; i++) {
          for (var element in _housesList) {
            if (element.houseAddress == user.userHouses![i].houseAddress &&
                element.houseNumber == user.userHouses![i].houseNumber) {
              user.userHouses![i] = element;
            }
          }
        }
      }

      currentHouse = userHousesList.isEmpty ? null : userHousesList.first;

      emit(MyHousesLoadedState(userHousesList, currentHouse));
    } catch (e) {
      print('MY_HOUSES_BLOC_ON_INIT_ERROR: $e');
    }
  }

  Future _onGetHousese(GetHousesToModalEvent event, Emitter<MyHousesState> emit) async {
    emit(ReturnedHouseseToAddHouseModal(_housesList));
  }

  Future _onFiltered(FilteredHousesToModalEvent event, Emitter<MyHousesState> emit) async {
    List<HouseModel> filteredList = [];

    for (var element in _housesList) {
      if (element.houseAddress.contains(event.value.trim()) || element.houseNumber.contains(event.value.trim())) {
        filteredList.add(element);
      }
    }

    emit(ReturnedHouseseToAddHouseModal(filteredList));
  }

  Future _onAddHouse(AddHouseToMyHouseseEvent event, Emitter<MyHousesState> emit) async {
    try {
      if (userHousesList.any((element) =>
          element.houseAddress == event.house.houseAddress && element.houseNumber == event.house.houseNumber)) {
        throw 'У вас уже добавлен этот дом';
      }
      final prefs = await SharedPreferences.getInstance();
      userHousesList.add(event.house);

      String? usersStringFromPrefs = prefs.getString(PreferencesUtils.usersKey);
      String? login = prefs.getString(PreferencesUtils.loginKey);

      List<UserModel> users = usersStringFromPrefs != null && usersStringFromPrefs.isNotEmpty
          ? usersModelFromJson(usersStringFromPrefs)
          : [];

      for (var i = 0; i < users.length; i++) {
        if (users[i].login == login) {
          if (users[i].userHouses != null) {
            users[i].userHouses!.add(event.house);
          } else {
            users[i].userHouses = [event.house];
          }
        }
      }

      prefs.setString(PreferencesUtils.usersKey, usersModelToJson(users));
      currentHouse = event.house;
      emit(MyHousesLoadedState(userHousesList, currentHouse!));
    } catch (e) {}
  }

  Future _onFilteredToChange(FilteredHousesToChangeHouseModalEvent event, Emitter<MyHousesState> emit) async {
    List<HouseModel> filteredList = [];

    for (var element in userHousesList) {
      if (element.houseAddress.contains(event.value.trim()) || element.houseNumber.contains(event.value.trim())) {
        filteredList.add(element);
      }
    }

    emit(ReturnedHouseseToChangeHouseModal(filteredList));
  }

  Future _onChangeCurrentActiveHouse(ChangeCurrentHomeEvent event, Emitter<MyHousesState> emit) async {
    currentHouse = event.house;
    emit(MyHousesLoadedState(userHousesList, currentHouse!));
  }

  Future _onSaveHouseToPrefs(SaveHouseToPrefs event, Emitter<MyHousesState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      for (var i = 0; i < _housesList.length; i++) {
        if (_housesList[i].houseAddress == currentHouse!.houseAddress ||
            _housesList[i].houseNumber == currentHouse!.houseNumber) {
          _housesList[i].workers = currentHouse!.workers;
        }
      }
      prefs.setString(PreferencesUtils.housesKey, houseModelToJson(_housesList));

      emit(MyHousesLoadedState(userHousesList, currentHouse!));
    } catch (e) {
      print('ON_SAVE_HOUSE_TO_PREFS_ERROR $e');
    }
  }

  Future _onClear(ClearDataEvent event, Emitter<MyHousesState> emit) async {
    currentHouse = null;
    currentUser = null;
    userHousesList.clear();
    emit(MyHousesLoadedState(userHousesList, currentHouse));
  }
}
