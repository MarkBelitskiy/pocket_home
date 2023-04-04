import 'package:easy_localization/easy_localization.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormatterUtils {
  static formattedDate(DateTime date, String languageCode) => DateFormat('d MMMM yyyy', languageCode).format(date);
  static var phoneFormatter = MaskTextInputFormatter(mask: '+7 (###) ### ####');
  static preparePhoneToMask(String phone) {
    return MaskTextInputFormatter(initialText: phone.replaceFirst(RegExp(r'^8'), ''), mask: '+7 (###) ### ####')
        .getMaskedText();
  }
}
