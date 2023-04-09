import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:pocket_home/common/utils/preferences_utils.dart';

import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MockPreferences extends Mock implements SharedPreferences {}

void main() async {
  MockPreferences mockPrefs = MockPreferences();
  WidgetsFlutterBinding.ensureInitialized();

  UserModel userModel = UserModel(
      phone: '+7 777 777 77 77',
      name: 'testName',
      photoPath: 'photoPath',
      password: 'testPassword',
      login: 'testLogin');
  group('MainUserRepo', () {
    test('should return null when there is no user string in prefs', () {
      when(mockPrefs.getString(PreferencesUtils.authenticatedUser)).thenReturn(null);

      final user = mockPrefs.getString(PreferencesUtils.authenticatedUser);

      expect(user, isNull);
      verify(mockPrefs.getString(PreferencesUtils.authenticatedUser));
      verifyNoMoreInteractions(mockPrefs);
    });

    test('should return UserModel when there is have user string in prefs', () {
      when(mockPrefs.getString(PreferencesUtils.authenticatedUser)).thenReturn(jsonEncode(userModel.toJson()));

      final user = UserModel.fromJson(jsonDecode(mockPrefs.getString(PreferencesUtils.authenticatedUser) ?? ''));

      expect(user, user);
      verify(mockPrefs.getString(PreferencesUtils.authenticatedUser));
      verifyNoMoreInteractions(mockPrefs);
    });
  });
}
