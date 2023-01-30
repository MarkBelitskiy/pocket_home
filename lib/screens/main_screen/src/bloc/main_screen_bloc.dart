import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  late SharedPreferences prefs;
  MainScreenBloc() : super(MainScreenInitial()) {
    on<OnInitAppEvent>(_onInit);
  }
  Future<void> _onInit(
      OnInitAppEvent event, Emitter<MainScreenState> emit) async {
    prefs = await SharedPreferences.getInstance();
    bool? isauthorized = prefs.getBool("authorized");
    if (isauthorized ?? false) {
      emit(UserSuccessLoadedState());
    }
    // try {
    //   await Future.delayed(const Duration(seconds: 2));
    // } catch (e) {}
  }
}
