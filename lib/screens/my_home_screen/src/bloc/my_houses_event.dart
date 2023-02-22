part of 'my_houses_bloc.dart';

abstract class MyHousesEvent {}

class InitHousesEvent extends MyHousesEvent {}

class GetHousesToModalEvent extends MyHousesEvent {}

class FilteredHousesToModalEvent extends MyHousesEvent {
  final String value;

  FilteredHousesToModalEvent(this.value);
}

class AddHouseToMyHouseseEvent extends MyHousesEvent {
  final HouseModel house;

  AddHouseToMyHouseseEvent(this.house);
}

class ChangeCurrentHomeEvent extends MyHousesEvent {
  final HouseModel house;

  ChangeCurrentHomeEvent(this.house);
}

class FilteredHousesToChangeHouseModalEvent extends MyHousesEvent {
  final String value;

  FilteredHousesToChangeHouseModalEvent(this.value);
}

class SaveHouseToPrefs extends MyHousesEvent {}

class ClearDataEvent extends MyHousesEvent {}
