part of 'main_app_bottom_sheet_bloc.dart';

abstract class MainAppBottomSheetEvent {}

class SearchItemsEvent extends MainAppBottomSheetEvent {
  final String value;

  SearchItemsEvent(this.value);
}
