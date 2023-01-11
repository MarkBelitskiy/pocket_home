import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forgot_pass_event.dart';
part 'forgot_pass_state.dart';

class ForgotPassBloc extends Bloc<ForgotPassEvent, ForgotPassState> {
  ForgotPassBloc() : super(ForgotPassInitial()) {
    on<ForgotPassEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
