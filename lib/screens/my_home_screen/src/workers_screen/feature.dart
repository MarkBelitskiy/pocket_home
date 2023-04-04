import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/widgets/floating_button/floating_action_button_widget.dart';
import 'package:pocket_home/common/widgets/floating_button/floating_button_access_enums.dart';
import 'package:pocket_home/common/widgets/lottie_animation_widget.dart';
import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';
import 'package:pocket_home/screens/my_home_screen/src/workers_screen/src/add_new_worker_screen.dart/src/worker_model.dart';
import 'bloc/workers_bloc.dart';
import 'src/add_new_worker_screen.dart/feature.dart';

part 'src/workers_screen.dart';

CupertinoPageRoute workersScreenFeature() {
  return CupertinoPageRoute(
    builder: (context) => BlocProvider(
      create: (context) => WorkersBloc(context.read<MyHousesBloc>())..add(InitWorkersEvent()),
      child: const _WorkersScreen(),
    ),
  );
}
