import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/locale_view_model.dart';
import 'package:pocket_home/common/widgets/error_snack.dart';

import 'package:pocket_home/common/widgets/lottie_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';

import 'package:pocket_home/screens/pdf_view/pdf_titled_screen.dart';
import 'package:provider/provider.dart';

import 'src/bloc/reports_bloc.dart';

part 'src/reports_screen.dart';

class ReportsScreenFeature extends StatelessWidget {
  const ReportsScreenFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsBloc(context.read<MyHousesBloc>()),
      child: const _ReportsScreen(),
    );
  }
}
