import 'package:flutter/cupertino.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'main_app_icons.dart';

part 'main_app_text_styles.dart';
part 'main_app_colors.dart';

class MainAppTheme {
  final bool isDark;

  MainAppTheme(this.isDark);

  Brightness get brightness => isDark ? Brightness.dark : Brightness.light;
  Brightness get statusBarBrightness => isDark ? Brightness.light : Brightness.dark;

  MainAppTextStyles get textStyles => MainAppTextStyles();

  MainAppIcons get icons => MainAppIcons();

  MainAppColors get colors => MainAppColors(isDark);
}
