import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/repository/repository.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Repository repository;
  AuthBloc({required this.repository}) : super(LoginScreenInitial()) {
    on<LoginEvent>(_loginEvent);
    on<InitAuthEvent>(_onInitAuth);
    on<LogOutEvent>(_onlogOut);
  }

  Future<void> _onlogOut(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(UserIsNotAuthorizedState());
  }

  Future<void> _onInitAuth(InitAuthEvent event, Emitter<AuthState> emit) async {
    UserModel? user = await repository.userRepo.getUser();

    if (user != null) {
      emit(AuthorizedSuccessState());
    } else {
      emit(UserIsNotAuthorizedState());
    }
  }

  Future<void> _loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      String? errorOnResponse = await repository.userRepo.authUser(login: event.login, password: event.password);
      if (errorOnResponse == null) {
        emit(AuthorizedSuccessState());
      } else {
        throw errorOnResponse;
      }
    } catch (e) {
      emit(AuthorizedErrorState(e.toString()));
    }
  }
}
