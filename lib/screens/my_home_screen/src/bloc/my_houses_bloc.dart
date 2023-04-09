import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/repository/repository.dart';
import 'package:pocket_home/common/utils/formatter_utils.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';

part 'my_houses_event.dart';
part 'my_houses_state.dart';

class MyHousesBloc extends Bloc<MyHousesEvent, MyHousesState> {
  final Repository repository;
  UserModel? currentUser;
  MyHousesBloc({required this.repository}) : super(MyHousesInitial()) {
    on<InitHousesEvent>(_onInit);
    on<GetHousesToModalEvent>(_onGetHousese);
    on<FilteredHousesToModalEvent>(_onFiltered);
    on<AddHouseToMyHouseseEvent>(_onAddHouse);
    on<FilteredHousesToChangeHouseModalEvent>(_onFilteredToChange);
    on<ChangeCurrentHomeEvent>(_onChangeCurrentActiveHouse);
    on<SaveHouseToPrefs>(_onSaveHouseToPrefs);
    on<ClearDataEvent>(_onClear);

    on<AddPaymentToBudget>(_paymentToBudget);
    on<UpdateIsManagerValueToFloatingButtonEvent>(_onUpdateIsManagerValue);
  }
  List<HouseModel> housesList = [];
  HouseModel? currentHouse;
  bool isManager = false;
  Future _onInit(InitHousesEvent event, Emitter<MyHousesState> emit) async {
    try {
      housesList = await repository.housesRepo.getHousesList();
      currentUser = await repository.userRepo.getUser();
      currentHouse = currentUser!.userHouses != null && currentUser!.userHouses!.isNotEmpty
          ? currentUser!.userHouses!.first
          : null;
      add(UpdateIsManagerValueToFloatingButtonEvent());
      emit(MyHousesLoadedState(currentUser!.userHouses ?? [], currentHouse, activateAnimation: true));
    } catch (e) {
      if (kDebugMode) {
        print('MY_HOUSES_BLOC_ON_INIT_ERROR: $e');
      }
    }
  }

  Future _onGetHousese(GetHousesToModalEvent event, Emitter<MyHousesState> emit) async {
    emit(ReturnedHouseseToAddHouseModal(housesList));
  }

  Future _onFiltered(FilteredHousesToModalEvent event, Emitter<MyHousesState> emit) async {
    List<HouseModel> filteredList = [];
    for (var element in housesList) {
      if (element.houseAddress.contains(event.value.trim()) || element.houseNumber.contains(event.value.trim())) {
        filteredList.add(element);
      }
    }

    emit(ReturnedHouseseToAddHouseModal(filteredList));
  }

  Future _onAddHouse(AddHouseToMyHouseseEvent event, Emitter<MyHousesState> emit) async {
    List<HouseModel> userHouses = currentUser!.userHouses ?? [];
    try {
      if (userHouses.any((element) =>
          element.houseAddress == event.house.houseAddress && element.houseNumber == event.house.houseNumber)) {
        throw 'youAlreadyAddThisHouse'.tr();
      }

      userHouses.add(event.house);
      currentUser!.userHouses = userHouses;
      currentHouse = event.house;
      add(UpdateIsManagerValueToFloatingButtonEvent());
      await repository.userRepo.updateUser(user: currentUser!);
      emit(MyHousesLoadedState(userHouses, currentHouse!));
    } catch (e) {
      if (kDebugMode) {
        print('MY_HOUSES_BLOC_ON_ADD_ERROR: $e');
      }
    }
  }

  Future _onFilteredToChange(FilteredHousesToChangeHouseModalEvent event, Emitter<MyHousesState> emit) async {
    List<HouseModel> filteredList = [];
    List<HouseModel> userHouses = currentUser!.userHouses ?? [];
    for (var element in userHouses) {
      if (element.houseAddress.contains(event.value.trim()) || element.houseNumber.contains(event.value.trim())) {
        filteredList.add(element);
      }
    }

    emit(ReturnedHouseseToChangeHouseModal(filteredList));
  }

  Future _onChangeCurrentActiveHouse(ChangeCurrentHomeEvent event, Emitter<MyHousesState> emit) async {
    currentHouse = event.house;
    add(UpdateIsManagerValueToFloatingButtonEvent());
    emit(MyHousesLoadedState(currentUser!.userHouses ?? [], currentHouse!));
  }

  Future _onSaveHouseToPrefs(SaveHouseToPrefs event, Emitter<MyHousesState> emit) async {
    try {
      List<HouseModel> userHouses = currentUser!.userHouses ?? [];

      int houseIndex = userHouses.indexWhere((element) =>
          element.houseAddress == currentHouse!.houseAddress && element.houseNumber == currentHouse!.houseNumber);

      if (houseIndex >= 0) {
        userHouses[houseIndex] = currentHouse!;
        currentUser!.userHouses = userHouses;
      }
      await repository.userRepo.updateUser(user: currentUser!);

      housesList = await repository.housesRepo.updateHouses(houseToUpdate: currentHouse!);

      emit(MyHousesLoadedState(currentUser!.userHouses ?? [], currentHouse!));
    } catch (e) {
      if (kDebugMode) {
        print('ON_SAVE_HOUSE_TO_PREFS_ERROR $e');
      }
    }
  }

  Future _onClear(ClearDataEvent event, Emitter<MyHousesState> emit) async {
    currentHouse = null;
    currentUser = null;

    emit(MyHousesLoadedState([], currentHouse));
  }

  Future _paymentToBudget(AddPaymentToBudget event, Emitter<MyHousesState> emit) async {
    currentHouse!.budget.budgetPaymentData.add(BudgetPayDataModel(
        paymentDate: DateTime.now(),
        paymentValue: event.paymentValue,
        paymentUserFullName: currentUser!.name,
        paymentUserPhone: currentUser!.phone));
    currentHouse!.budget.budgetTotalSum += event.paymentValue;
    add(SaveHouseToPrefs());
  }

  Future _onUpdateIsManagerValue(UpdateIsManagerValueToFloatingButtonEvent event, Emitter<MyHousesState> emit) async {
    if (currentHouse != null && currentUser != null) {
      isManager = FormatterUtils.preparePhoneToMask(currentHouse!.manager.phone) ==
          FormatterUtils.preparePhoneToMask(currentUser!.phone);

      emit(UpdateIsManagerState(isManager, currentHouse));
    }
  }
}
