import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pocket_home/common/repository/base_repository_models.dart/base_user_repository.dart';
import 'package:pocket_home/common/repository/repository.dart';

import 'package:pocket_home/screens/login_screen/src/bloc/auth_bloc.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockRepository extends Mock implements Repository {
  @override
  BaseUserRepository userRepo = MockUserRepository();
}

class MockUserRepository extends Mock implements BaseUserRepository {
  @override
  Future logOutUser() async {}

  @override
  Future<UserModel?> getUser() async {
    return UserModel(
        phone: '+7 777 777 77 77',
        name: 'testName',
        photoPath: 'photoPath',
        password: 'testPassword',
        login: 'testLogin');
  }
}

class MockPreferences extends Mock implements SharedPreferences {}

void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;
    late MockRepository mockRepository;

    setUp(() async {
      mockRepository = MockRepository();

      authBloc = AuthBloc(repository: mockRepository);
    });

    test('initial state is LoginScreenInitial', () {
      expect(authBloc.state, isA<LoginScreenInitial>());
    });

    test('LogOutEvent should emit UserIsNotAuthorizedState', () {
      authBloc.add(LogOutEvent());

      expectLater(authBloc.stream, emitsInOrder([isA<UserIsNotAuthorizedState>()]));
    });

    test('InitAuthEvent should return AuthorizedSuccessState if UserModel is not null', () async {
      authBloc.add(InitAuthEvent());
      expect(UserModel, isNotNull);
      await expectLater(authBloc.stream, emitsInOrder([isA<AuthorizedSuccessState>()]));
    });
  });
}
