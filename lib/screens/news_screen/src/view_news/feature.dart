import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/utils/formatter_utils.dart';
import 'package:pocket_home/screens/news_screen/src/news_model.dart';

import '../../../../common/theme/theme_getter.dart';
import '../../../../common/widgets/main_app_bar_widget.dart';
import '../../../../common/widgets/main_body_widget.dart';
part 'src/view_news_screen.dart';

CupertinoPageRoute viewNewsScreenFeature(NewsModel news) {
  return CupertinoPageRoute(
    builder: (context) => _ViewNewsScreen(
      news: news,
    ),
  );
}
