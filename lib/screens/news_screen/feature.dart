import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/repository/repository.dart';
import 'package:pocket_home/common/theme/main_app_theme/main_app_theme_view_model.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/formatter_utils.dart';
import 'package:pocket_home/common/widgets/floating_button/floating_action_button_widget.dart';
import 'package:pocket_home/common/widgets/floating_button/floating_button_access_enums.dart';
import 'package:pocket_home/common/widgets/lottie_animation_widget.dart';

import 'package:flutter/material.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';
import 'package:provider/provider.dart';

import 'src/add_news/feature.dart';
import 'src/bloc/news_bloc.dart';
import '../../common/repository/models/news_model.dart';
import 'src/view_news/feature.dart';

part 'src/news_screen.dart';

class NewsScreenFeature extends StatelessWidget {
  const NewsScreenFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(
        repository: context.read<Repository>(),
        myHousesBloc: context.read<MyHousesBloc>(),
      ),
      child: const _NewsScreen(),
    );
  }
}
