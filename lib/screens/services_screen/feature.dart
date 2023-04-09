import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/repository/repository.dart';

import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/utils/formatter_utils.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/floating_button/floating_action_button_widget.dart';
import 'package:pocket_home/common/widgets/floating_button/floating_button_access_enums.dart';
import 'package:pocket_home/common/widgets/lottie_animation_widget.dart';

import 'package:flutter/material.dart';
import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';
import 'package:pocket_home/screens/services_screen/src/bloc/services_bloc.dart';

import 'src/add_service_screen/feature.dart';
import 'src/service_detailed_model.dart';
import 'src/services_detailed_screen.dart/feature.dart';
part 'src/services_screen.dart';

class ServicesScreenFeature extends StatelessWidget {
  const ServicesScreenFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServicesBloc(
        repository: context.read<Repository>(),
        myHousesBloc: context.read<MyHousesBloc>(),
      ),
      child: const _ServicesScreen(),
    );
  }
}
