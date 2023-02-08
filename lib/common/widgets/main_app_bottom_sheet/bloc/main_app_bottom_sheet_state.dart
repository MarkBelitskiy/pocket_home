part of 'main_app_bottom_sheet_bloc.dart';

abstract class MainAppBottomSheetState {}

class MainAppBottomSheetInitial extends MainAppBottomSheetState {}

class ElementsLoadedState extends MainAppBottomSheetState {
  final List<String> items;

  ElementsLoadedState(this.items);
}
