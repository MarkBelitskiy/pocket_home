import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';

class EmptyPlaceholderWithLottie extends StatelessWidget {
  final String lottiePath;
  final EdgeInsets margin;
  final String? title;
  const EmptyPlaceholderWithLottie(
      {Key? key, required this.lottiePath, this.title, required this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return lottiePath.isNotEmpty
        ? Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/blob_lottie.svg',
                      width: MediaQuery.of(context).size.width,
                    ),
                    if (title != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        title!,
                        style: getMainAppTheme(context)
                            .textStyles
                            .title
                            .copyWith(
                                color: getMainAppTheme(context)
                                    .colors
                                    .mainTextColor),
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
        : const SizedBox.shrink();
  }
}
