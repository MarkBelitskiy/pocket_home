import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_home/common/theme/main_app_theme/main_app_theme_view_model.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:provider/provider.dart';

class EmptyPlaceholderWithLottie extends StatelessWidget {
  final String lottiePath;
  final EdgeInsets margin;
  final String? title;
  const EmptyPlaceholderWithLottie({Key? key, required this.lottiePath, this.title, required this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainAppThemeViewModel>(
      builder: (context, value, child) => lottiePath.isNotEmpty
          ? Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        getMainAppTheme(context).icons.lottieBlob,
                        width: MediaQuery.of(context).size.width,
                      ),
                      if (title != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          title!,
                          style: getMainAppTheme(context)
                              .textStyles
                              .title
                              .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                          textAlign: TextAlign.center,
                        ).tr(),
                        const SizedBox(height: 32),
                      ]
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    margin: margin,
                    child: Lottie.asset(
                      lottiePath,
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: MediaQuery.of(context).size.width / 1.3,
                      frameRate: FrameRate.max,
                    ),
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
