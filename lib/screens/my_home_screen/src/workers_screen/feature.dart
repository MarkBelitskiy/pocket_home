import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/widgets/floating_button/floating_action_button_widget.dart';
import 'package:pocket_home/common/widgets/floating_button/floating_button_access_enums.dart';
import 'package:pocket_home/common/widgets/lottie_animation_widget.dart';
import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/common/repository/models/my_home_model.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';
import 'package:pocket_home/common/repository/models/worker_model.dart';
import 'bloc/workers_bloc.dart';
import 'src/add_new_worker_screen.dart/feature.dart';

part 'src/workers_screen.dart';

CupertinoPageRoute workersScreenFeature(HouseModel currentHouse) {
  return CupertinoPageRoute(
    builder: (context) => BlocProvider(
      create: (context) =>
          WorkersBloc(myHousesBloc: context.read<MyHousesBloc>(), currentHouse: currentHouse)..add(InitWorkersEvent()),
      child: const _WorkersScreen(),
    ),
  );
}
