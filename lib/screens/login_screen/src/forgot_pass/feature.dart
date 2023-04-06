import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/common/widgets/main_body_widget.dart';
import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';
import 'package:pocket_home/common/widgets/otp/feature.dart';
import 'package:pocket_home/screens/login_screen/src/forgot_pass/src/reset_password_screen/feature.dart';
import 'package:url_launcher/url_launcher.dart';

part 'src/forgot_pass_screen.dart';

CupertinoPageRoute forgotPassScreenFeature() {
  return CupertinoPageRoute(
    builder: (context) => const _ForgotPassScreen(),
  );
}
