import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';

void returnSnackBar(BuildContext context, String error) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: getMainAppTheme(context).colors.textOnBgColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        content: Row(children: [
          SvgPicture.asset(
            getMainAppTheme(context).icons.error,
            color: ColorPalette.red500,
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Text(
              error,
              style: getMainAppTheme(context)
                  .textStyles
                  .body
                  .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
            ).tr(),
          )
        ]),
        duration: const Duration(seconds: 2),
      ),
    );
}
