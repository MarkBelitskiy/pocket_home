import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/widgets/floating_action_button_widget.dart';
import 'package:pocket_home/common/widgets/lottie_animation_widget.dart';

import 'package:flutter/material.dart';
import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/common/widgets/main_body_widget.dart';
import 'package:pocket_home/screens/services_screen/src/bloc/services_bloc.dart';

import 'src/add_service_screen/feature.dart';
import 'src/service_item_model.dart';

part 'src/services_screen.dart';

class ServicesScreenFeature extends StatelessWidget {
  const ServicesScreenFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServicesBloc()..add(InitEvent()),
      child: const _ServicesScreen(),
    );
  }
}
