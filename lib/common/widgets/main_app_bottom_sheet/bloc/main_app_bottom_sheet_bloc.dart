import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_app_bottom_sheet_event.dart';
part 'main_app_bottom_sheet_state.dart';

class MainAppBottomSheetBloc extends Bloc<MainAppBottomSheetEvent, MainAppBottomSheetState> {
  final List<String> items;
  MainAppBottomSheetBloc(this.items) : super(ElementsLoadedState(items)) {
    on<SearchItemsEvent>(_searchItemsEvent);
  }

  Future<void> _searchItemsEvent(SearchItemsEvent event, Emitter<MainAppBottomSheetState> emit) async {
    List<String> _itemsFromSearch = [];

    for (var element in items) {
      if (event.value.isNotEmpty) {
        if (element.toLowerCase().trim().contains(event.value.toLowerCase().trim())) {
          _itemsFromSearch.add(element);
        }
        emit(ElementsLoadedState(_itemsFromSearch));
      } else {
        emit(ElementsLoadedState(items));
      }
    }
  }
}
