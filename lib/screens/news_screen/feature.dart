import 'dart:io';

import 'package:easy_localization/easy_localization.dart' as locale;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/widgets/floating_action_button_widget.dart';
import 'package:pocket_home/common/widgets/lottie_animation_widget.dart';

import 'package:flutter/material.dart';

import 'src/add_news/feature.dart';
import 'src/bloc/news_bloc.dart';
import 'src/news_model.dart';

part 'src/news_screen.dart';

class NewsScreenFeature extends StatelessWidget {
  const NewsScreenFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc()..add(OnNewsTabInit()),
      child: const _NewsScreen(),
    );
  }
}
