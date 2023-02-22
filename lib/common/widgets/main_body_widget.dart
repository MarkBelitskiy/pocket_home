import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';

class MainAppBody extends StatelessWidget {
  const MainAppBody({Key? key, required this.children, this.needPadding = true}) : super(key: key);

  final List<Widget> children;
  final bool needPadding;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              bottom: -1,
              right: 0,
              child: SvgPicture.asset(
                getMainAppTheme(context).icons.emptySingleBlob,
                width: MediaQuery.of(context).size.width,
              )),
          Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
                padding: EdgeInsets.all(needPadding ? 50 : 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                )),
          ),
        ],
      ),
    );
  }
}
