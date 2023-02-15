import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/lottie_animation_widget.dart';

import 'package:flutter/material.dart';
import 'package:pocket_home/screens/pdf_view/pdf_titled_screen.dart';

import 'src/bloc/reports_bloc.dart';
import 'src/rating_report_model.dart';

part 'src/reports_screen.dart';

class ReportsScreenFeature extends StatelessWidget {
  const ReportsScreenFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsBloc(),
      child: const _ReportsScreen(),
    );
  }
}
