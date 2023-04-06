import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/file_picker_widget/feature.dart';
import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/common/widgets/main_app_bottom_sheet/main_app_bottom_sheet.dart';

import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';
import 'package:pocket_home/screens/services_screen/src/add_service_screen/src/bloc/add_service_bloc.dart';
import 'package:pocket_home/screens/services_screen/src/bloc/services_bloc.dart';
import 'package:pocket_home/screens/services_screen/src/service_detailed_model.dart';
import 'package:provider/provider.dart';

import 'src/change_person_data_modal.dart';

part 'src/add_service_screen.dart';
part 'src/view_model.dart';

CupertinoPageRoute addServicesScreenFeature(final ServicesBloc servicesBloc, HouseModel currentHouse) {
  return CupertinoPageRoute(
    builder: (context) => BlocProvider(
      create: (context) => AddServiceBloc(servicesBloc: servicesBloc, currentHouse: currentHouse),
      child: ChangeNotifierProvider(
          create: (context) => AddServicesScreenViewModel()..init(context.read<MyHousesBloc>().currentUser!),
          child: const _AddServiceScreen()),
    ),
  );
}
