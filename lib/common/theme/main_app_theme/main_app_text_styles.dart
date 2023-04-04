part of 'main_app_theme.dart';

class MainAppTextStyles {
  TextStyle get title => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 20,
      );
  TextStyle get boldTitle => const TextStyle(fontWeight: FontWeight.w600, fontSize: 20);
  TextStyle get body => const TextStyle(fontWeight: FontWeight.w400, fontSize: 16);
  TextStyle get boldBody => const TextStyle(fontWeight: FontWeight.w600, fontSize: 16);
  TextStyle get subBody => const TextStyle(fontWeight: FontWeight.w400, fontSize: 14);
  TextStyle get boldSubBody => const TextStyle(fontWeight: FontWeight.w600, fontSize: 14);
  TextStyle get caption => const TextStyle(fontWeight: FontWeight.w400, fontSize: 10);
  TextStyle get boldCaption => const TextStyle(fontWeight: FontWeight.w600, fontSize: 10);
}
