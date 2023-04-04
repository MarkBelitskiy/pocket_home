
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_pass_event.dart';
part 'forgot_pass_state.dart';

class ForgotPassBloc extends Bloc<ForgotPassEvent, ForgotPassState> {
  ForgotPassBloc() : super(ForgotPassInitial()) {
    on<ForgotPassEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
