import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/utils/formatter_utils.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/error_snack.dart';
import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/common/widgets/main_app_bottom_sheet/main_app_bottom_sheet.dart';
import 'package:pocket_home/common/widgets/main_body_widget.dart';
import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';
import 'package:pocket_home/common/repository/models/worker_model.dart';

import 'package:provider/provider.dart';

import 'src/view_model.dart';

part 'src/add_new_workers_screen.dart';

CupertinoPageRoute addNewWorkersScreenFeature() {
  return CupertinoPageRoute(
    builder: (context) => ChangeNotifierProvider(
        create: (BuildContext context) => AddNewWorkersViewModel(), child: const _AddNewWorkersScreen()),
  );
}
