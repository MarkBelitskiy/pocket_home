import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_news_event.dart';
part 'add_news_state.dart';

class AddNewsBloc extends Bloc<AddNewsEvent, AddNewsState> {
  AddNewsBloc() : super(AddNewsInitial()) {
    on<AddNewsEvent>((event, emit) {
      if (event is ChangeBodyEvent) {
        _changeBodyEvent(event, emit);
      }
    });
  }

  Future<void> _changeBodyEvent(
      ChangeBodyEvent event, Emitter<AddNewsState> emit) async {
    if (event.bodyValue == 0) emit(NewsBodyState());

    if (event.bodyValue == 1) emit(PollsBodyState());
  }
}
