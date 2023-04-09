import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/repository/repository.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserModel? profile;
  final Repository repository;
  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<InitEvent>(_onInit);

    on<UpdateProfileEvent>(_onUpdate);
  }

  Future _onUpdate(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    await repository.userRepo.updateUser(user: event.profile);
  }

  Future _onInit(InitEvent event, Emitter<ProfileState> emit) async {
    profile = await repository.userRepo.getUser();
    if (profile == null) {
      emit(ProfileLoadedErrorState());
    } else {
      emit(ProfileLoadedState(profile!));
    }
  }
}
