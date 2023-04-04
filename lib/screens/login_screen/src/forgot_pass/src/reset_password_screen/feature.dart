import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/common/widgets/main_body_widget.dart';
import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';
import 'package:pocket_home/screens/login_screen/src/forgot_pass/src/reset_password_screen/src/view_model.dart';

import 'package:provider/provider.dart';

part 'src/reset_password_screen.dart';

CupertinoPageRoute resetPasswordScreenFeature() {
  return CupertinoPageRoute(
    builder: (context) =>
        ChangeNotifierProvider(create: (context) => ResetPasswordModel()..init(), child: const _ResetPasswordScreen()),
  );
}
