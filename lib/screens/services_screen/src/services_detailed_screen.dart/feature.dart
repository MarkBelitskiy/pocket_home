import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/utils/formatter_utils.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';

import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';

import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';
import 'package:pocket_home/screens/my_home_screen/src/workers_screen/src/add_new_worker_screen.dart/src/worker_model.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';
import 'package:pocket_home/screens/services_screen/src/bloc/services_bloc.dart';

import 'package:pocket_home/screens/services_screen/src/service_detailed_model.dart';

import 'src/bloc/chose_service_person_bloc.dart';

part 'src/services_detailed_screen.dart';

CupertinoPageRoute servicesDetailedScreenFeature(final ServiceDetailedModel model, final int numberOfService,
    final ServicesBloc servicesBloc, final HouseModel currentHouse, final UserModel user) {
  return CupertinoPageRoute(
    builder: (context) => _ServicesDetailedScreen(
      model: model,
      numberOfService: numberOfService,
      servicesBloc: servicesBloc,
      currentHouse: currentHouse,
      user: user,
    ),
  );
}
