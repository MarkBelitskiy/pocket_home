import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';

class MainAppBody extends StatelessWidget {
  const MainAppBody(
      {Key? key, required this.isDoubleBlob, required this.children})
      : super(key: key);
  final bool isDoubleBlob;
  final List<Widget> children;
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
                padding: const EdgeInsets.all(50),
                child: Column(
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
