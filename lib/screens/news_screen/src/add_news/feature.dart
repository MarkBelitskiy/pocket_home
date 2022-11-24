import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/common/widgets/main_app_bottom_sheet/main_app_bottom_sheet.dart';
import 'package:pocket_home/common/widgets/main_body_widget.dart';
import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';
import 'package:pocket_home/common/widgets/upload_files/components/upload_files_enums.dart';
import 'package:pocket_home/common/widgets/upload_files/feature.dart';

part 'src/add_news_screen.dart';

CupertinoPageRoute addNewsScreenFeature() {
  return CupertinoPageRoute(builder: (context) => _AddNewsScreen());
}
