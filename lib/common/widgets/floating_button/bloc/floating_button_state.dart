part of 'floating_button_bloc.dart';

abstract class FloatingButtonState {}

class FloatingButtonInitial extends FloatingButtonState {}

class ShowButtonState extends FloatingButtonState {
  final HouseModel? currentHouse;

  ShowButtonState(this.currentHouse);
}
