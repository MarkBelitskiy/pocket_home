part of 'main_app_theme.dart';

class MainAppColors {
  final bool isDark;

  MainAppColors(this.isDark);

  Color get bgColor => isDark ? ColorPalette.grey900 : ColorPalette.turquoise100;
  Color get borderColors => isDark ? ColorPalette.grey600 : ColorPalette.grey200;
  Color get cardColor => isDark ? ColorPalette.grey800 : ColorPalette.turquoise200;
  Color get buttonsColor => isDark ? ColorPalette.grey700 : ColorPalette.turquoise500;
  Color get mainTextColor => ColorPalette.grey100;
  Color get inactiveText => isDark ? ColorPalette.grey300 : ColorPalette.grey350;
  Color get activeText => isDark ? ColorPalette.blue500 : ColorPalette.blue550;
  Color get inactiveColor => isDark ? ColorPalette.grey300 : ColorPalette.grey350;
  Color get activeColor => isDark ? ColorPalette.blue500 : ColorPalette.blue550;
  Color get navBarColor => isDark ? ColorPalette.grey800 : ColorPalette.blue400;
  Color get shadowColor => isDark ? ColorPalette.grey900.withOpacity(0.3) : ColorPalette.grey350.withOpacity(0.3);
  Color get tabBgColor => isDark ? ColorPalette.grey600 : ColorPalette.blueGreen600;
  Color get tabActiveColor => isDark ? ColorPalette.grey700 : ColorPalette.blueGreen400;
  Color get iconOnButtonColor => ColorPalette.grey100;
  Color get accentTextColor => isDark ? ColorPalette.blue200 : ColorPalette.grey100;
  Color get textOnBgColor => ColorPalette.grey400;
  Color get activeBottomBarIconColor => ColorPalette.grey100;
  Color get successColor => isDark ? ColorPalette.green500 : ColorPalette.orange500;
}
