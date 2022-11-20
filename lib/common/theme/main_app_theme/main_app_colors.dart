part of 'main_app_theme.dart';

class _MainAppColors {
  final bool isDark;

  _MainAppColors(this.isDark);

  Color get bgColor => ColorPalette.grey900;
  Color get borderColors => ColorPalette.grey400;
  Color get cardColor => ColorPalette.grey500;
  Color get buttonsColor => ColorPalette.grey700;
  Color get mainTextColor => ColorPalette.grey100;
  Color get inactiveText => ColorPalette.grey300;
  Color get activeText => ColorPalette.blue500;
  Color get inactiveColor => ColorPalette.grey300;
  Color get activeColor => ColorPalette.blue500;
  Color get accent => ColorPalette.blue200;
  Color get errorTextColor => ColorPalette.red500;
}
