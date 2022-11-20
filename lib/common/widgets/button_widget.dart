import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pocket_home/common/theme/theme_getter.dart';

class MainAppButton extends StatelessWidget {
  const MainAppButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.suffixWidget,
      required this.assetIcon});
  final Function onPressed;
  final String title;
  final String assetIcon;
  final Widget? suffixWidget;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onPressed.call(),
      color: getMainAppTheme(context).colors.buttonsColor,
      padding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        SvgPicture.asset(
          assetIcon,
          width: 24,
          height: 24,
          color: getMainAppTheme(context).colors.mainTextColor,
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: getMainAppTheme(context)
                .textStyles
                .title
                .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        if (suffixWidget != null) suffixWidget!
      ]),
    );
  }
}
