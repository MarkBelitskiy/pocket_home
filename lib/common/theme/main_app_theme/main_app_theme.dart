import 'package:flutter/cupertino.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
part 'main_app_text_styles.dart';
part 'main_app_icons.dart';
part 'main_app_colors.dart';

class MainAppTheme {
  final bool isDark;

  MainAppTheme(this.isDark);

  Brightness get brightness => isDark ? Brightness.dark : Brightness.light;
  Brightness get statusBarBrightness =>
      isDark ? Brightness.light : Brightness.dark;
  // ignore: library_private_types_in_public_api
  _MainAppTextStyles get textStyles => _MainAppTextStyles();
  // ignore: library_private_types_in_public_api
  _MainAppIcons get icons => _MainAppIcons();
  // ignore: library_private_types_in_public_api
  _MainAppColors get colors => _MainAppColors(isDark);
}
