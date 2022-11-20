import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/widgets/floating_action_button_widget.dart';
import 'package:pocket_home/common/widgets/lottie_animation_widget.dart';

import 'package:flutter/material.dart';

import 'src/add_news/feature.dart';

part 'src/news_screen.dart';

class NewsScreenFeature extends StatelessWidget {
  const NewsScreenFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _NewsScreen();
  }
}
