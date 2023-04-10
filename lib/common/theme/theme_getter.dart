import 'package:flutter/cupertino.dart';
import 'package:pocket_home/common/theme/main_app_theme/main_app_theme.dart';
import 'package:provider/provider.dart';

import 'main_app_theme/main_app_theme_view_model.dart';

MainAppTheme getMainAppTheme(BuildContext context) {
  return context.read<MainAppViewModel>().theme;
}
