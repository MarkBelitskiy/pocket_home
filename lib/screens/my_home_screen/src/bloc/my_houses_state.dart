part of 'my_houses_bloc.dart';

abstract class MyHousesState {}

class MyHousesInitial extends MyHousesState {}

class MyHousesLoadedState extends MyHousesState {
  final List<HouseModel> houses;
  final HouseModel? currentHouse;
  final bool activateAnimation;
  MyHousesLoadedState(this.houses, this.currentHouse, {this.activateAnimation = false});
}

class ReturnedHouseseToAddHouseModal extends MyHousesState {
  final List<HouseModel> houses;

  ReturnedHouseseToAddHouseModal(this.houses);
}

class ReturnedHouseseToChangeHouseModal extends MyHousesState {
  final List<HouseModel> houses;

  ReturnedHouseseToChangeHouseModal(this.houses);
}

class UpdateIsManagerState extends MyHousesState {
  final bool isManager;

  UpdateIsManagerState(this.isManager);
}
