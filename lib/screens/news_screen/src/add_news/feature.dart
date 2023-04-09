import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/repository/repository.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/error_snack.dart';
import 'package:pocket_home/common/widgets/file_picker_widget/feature.dart';

import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/common/widgets/main_app_bottom_sheet/main_app_bottom_sheet.dart';
import 'package:pocket_home/common/widgets/main_body_widget.dart';
import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';
import 'package:pocket_home/screens/my_home_screen/my_home_model.dart';
import 'package:pocket_home/screens/news_screen/src/add_news/src/bloc/add_news_bloc.dart';
import 'package:pocket_home/screens/news_screen/src/bloc/news_bloc.dart';

import 'package:pocket_home/screens/news_screen/src/news_model.dart';

part 'src/add_news_screen.dart';

CupertinoPageRoute addNewsScreenFeature(HouseModel currentHouse, NewsBloc newsBloc) {
  return CupertinoPageRoute(
      builder: (context) => BlocProvider(
            create: (context) =>
                AddNewsBloc(repository: context.read<Repository>(), currentHouse: currentHouse, newsBloc: newsBloc),
            child: const _AddNewsScreen(),
          ));
}
