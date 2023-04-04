import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:pocket_home/common/utils/preferences_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_app_theme.dart';

class MainAppThemeViewModel extends ChangeNotifier {
  SharedPreferences? _preferences;
  MainAppTheme? _theme;
  Brightness? _themeBrightness;

  MainAppTheme get theme => _theme ?? (throw 'Getter "theme" was called on null');

  void init(SharedPreferences preferences) {
    _preferences = preferences;

    getSystemBrightness();

    final brightness = _preferences?.getString(PreferencesUtils.brightnessKey);

    if (brightness == null) {
    } else {
      if (brightness == Brightness.dark.toString()) {
        _themeBrightness = Brightness.dark;
      } else {
        _themeBrightness = Brightness.light;
      }
    }
  }

  void changeTheme(Brightness brightness) async {
    if (_themeBrightness != brightness) {
      _themeBrightness = brightness;
      await _preferences?.setString(PreferencesUtils.brightnessKey, brightness.toString());
      _theme = MainAppTheme(_themeBrightness == Brightness.dark);
      notifyListeners();
    }
  }

  void getSystemBrightness() async {
    _themeBrightness = SchedulerBinding.instance.window.platformBrightness;

    _theme = MainAppTheme(_themeBrightness == Brightness.dark);
    if (_themeBrightness == Brightness.dark) notifyListeners();
    await _preferences?.setString(PreferencesUtils.brightnessKey, _themeBrightness.toString());
  }
}
