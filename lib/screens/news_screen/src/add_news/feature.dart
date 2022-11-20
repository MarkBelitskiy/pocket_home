import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';

part 'src/add_news_screen.dart';

CupertinoPageRoute addNewsScreenFeature() {
  return CupertinoPageRoute(builder: (context) => _AddNewsScreen());
}
