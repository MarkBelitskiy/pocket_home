import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';

import 'package:pocket_home/common/utils/locale_view_model.dart';

import 'package:flutter/material.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/file_picker_widget/feature.dart';
import 'package:pocket_home/common/widgets/main_body_widget.dart';
import 'package:pocket_home/screens/main_screen/src/bloc/main_screen_bloc.dart';
import 'package:pocket_home/screens/registration_screen/src/profile_model.dart';
import 'package:provider/provider.dart';

import 'src/bloc/profile_bloc.dart';

part 'src/profile_screen.dart';

class ProfileScreenFeature extends StatelessWidget {
  const ProfileScreenFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(InitEvent()),
      child: const _ProfileScreen(),
    );
  }
}
