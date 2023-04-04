import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';

class MainAppBody extends StatelessWidget {
  const MainAppBody({Key? key, required this.children, this.needPadding = true}) : super(key: key);

  final List<Widget> children;
  final bool needPadding;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: SvgPicture.asset(
            getMainAppTheme(context).icons.emptyDoubleBlob,
            color: getMainAppTheme(context).colors.cardColor,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Positioned.fill(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(needPadding ? 50 : 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
