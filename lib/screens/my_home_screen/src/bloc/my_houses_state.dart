part of 'my_houses_bloc.dart';

abstract class MyHousesState {}

class MyHousesInitial extends MyHousesState {}

class MyHousesLoadedState extends MyHousesState {
  final List<HouseModel> houses;
  final HouseModel? currentHouse;
  MyHousesLoadedState(this.houses, this.currentHouse);
}

class ReturnedHouseseToAddHouseModal extends MyHousesState {
  final List<HouseModel> houses;

  ReturnedHouseseToAddHouseModal(this.houses);
}

class ReturnedHouseseToChangeHouseModal extends MyHousesState {
  final List<HouseModel> houses;

  ReturnedHouseseToChangeHouseModal(this.houses);
}
