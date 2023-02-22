import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:flutter/material.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/floating_action_button_widget.dart';

import 'package:pocket_home/common/widgets/lottie_animation_widget.dart';
import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'src/bloc/my_houses_bloc.dart';
import 'src/workers_screen/feature.dart';

part 'src/my_home.dart';

class MyHousesScreanFeature extends StatelessWidget {
  const MyHousesScreanFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _MyHousesScreen();
  }
}
