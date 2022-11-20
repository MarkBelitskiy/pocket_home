import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';

import 'package:pocket_home/common/utils/locale_view_model.dart';

import 'package:flutter/material.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:provider/provider.dart';

part 'src/profile_screen.dart';

class ProfileScreenFeature extends StatelessWidget {
  const ProfileScreenFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _ProfileScreen();
  }
}
