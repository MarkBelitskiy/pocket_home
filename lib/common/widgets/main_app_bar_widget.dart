import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, required this.title, this.actions});
  final String title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      backgroundColor: getMainAppTheme(context).colors.buttonsColor,
      elevation: 1,
      shadowColor: ColorPalette.grey900.withOpacity(0.3),
      centerTitle: true,
      title: Text(
        title,
        style: getMainAppTheme(context)
            .textStyles
            .title
            .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
      ),
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset(
            getMainAppTheme(context).icons.chevronLeft,
            color: getMainAppTheme(context).colors.mainTextColor,
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
