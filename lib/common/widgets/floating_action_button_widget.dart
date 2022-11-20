import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';

class MainAppFloatingButton extends StatelessWidget {
  const MainAppFloatingButton({super.key, required this.onTap});
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        onTap.call();
      },
      backgroundColor: getMainAppTheme(context).colors.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SvgPicture.asset(getMainAppTheme(context).icons.add),
    );
  }
}
