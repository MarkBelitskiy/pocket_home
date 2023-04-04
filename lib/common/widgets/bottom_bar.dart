import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/locale_view_model.dart';
import 'package:pocket_home/screens/main_screen/feature.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';
import 'package:pocket_home/screens/news_screen/src/bloc/news_bloc.dart';
import 'package:pocket_home/screens/services_screen/src/bloc/services_bloc.dart';
import 'package:provider/provider.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  CustomNavBarState createState() => CustomNavBarState();
}

class CustomNavBarState extends State<CustomNavBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final int _count = 5;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, value: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainAppLocaleViewModel>(builder: (context, value, child) {
      return SizedBox(
        height: 100,
        child: Stack(
          children: <Widget>[
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) => CustomPaint(
                    painter: _NavBarPainter(_animationController.value, _count,
                        navBarColor: getMainAppTheme(context).colors.navBarColor,
                        borderColor: getMainAppTheme(context).colors.bgColor),
                    child: const SizedBox(
                      height: 75.0,
                    ),
                  ),
                )),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Row(
                children: [
                  _NavBarItem(
                    icon: getMainAppTheme(context).icons.news,
                    title: 'news',
                    index: 0,
                    callback: () {
                      updatePosition(0);
                    },
                  ),
                  _NavBarItem(
                    icon: getMainAppTheme(context).icons.services,
                    title: 'services',
                    index: 1,
                    callback: () {
                      updatePosition(1);
                    },
                  ),
                  _NavBarItem(
                    icon: getMainAppTheme(context).icons.buildingIcon,
                    title: 'myhouses',
                    index: 2,
                    callback: () {
                      updatePosition(2);
                    },
                  ),
                  _NavBarItem(
                    icon: getMainAppTheme(context).icons.reports,
                    title: 'reports',
                    index: 3,
                    callback: () {
                      updatePosition(3);
                    },
                  ),
                  _NavBarItem(
                    icon: getMainAppTheme(context).icons.profile,
                    title: 'profile',
                    index: 4,
                    callback: () {
                      updatePosition(4);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  void updatePosition(int index) {
    _animationController.animateTo(index / _count,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }
}

class _NavBarPainter extends CustomPainter {
  late double loc;
  late double s;
  final Color navBarColor;
  final Color borderColor;
  _NavBarPainter(double startingLoc, int itemsLength, {required this.navBarColor, required this.borderColor}) {
    final span = 1.0 / itemsLength;
    s = 0.2;
    loc = startingLoc + (span - s) / 2;
  }
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = navBarColor
      ..style = PaintingStyle.fill;
    final paintBorder = Paint()
      ..color = borderColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo((loc - 0.1) * size.width, 0)
      ..cubicTo(
        (loc + s * 0.20) * size.width,
        size.height * 0.05,
        loc * size.width,
        size.height * 0.60,
        (loc + s * 0.50) * size.width,
        size.height * 0.60,
      )
      ..cubicTo(
        (loc + s) * size.width,
        size.height * 0.60,
        (loc + s - s * 0.20) * size.width,
        size.height * 0.05,
        (loc + s + 0.1) * size.width,
        0,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, paintBorder);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

class _NavBarItem extends StatefulWidget {
  const _NavBarItem({Key? key, required this.icon, required this.index, required this.title, required this.callback})
      : super(key: key);
  final String icon;
  final int index;
  final Function callback;
  final String title;

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.callback.call();
          context.read<MainScreenViewModel>().changeScreen(widget.index);
          // if (widget.index == 1) {
          //   context.read<ServicesBloc>().add(InitEvent());
          // }
          // if (widget.index == 0) {
          //   context.read<NewsBloc>().add(OnNewsTabInit());
          // }
          if (widget.index == 2) {
            context.read<MyHousesBloc>().add(ActivateIntroEvent());
          }
        },
        child: Consumer<MainScreenViewModel>(builder: (context, value, child) {
          bool isActive = value.activeIndex == widget.index;
          return Container(
            margin: EdgeInsets.only(bottom: isActive ? 40 : 0),
            padding: EdgeInsets.all(isActive ? 12 : 0),
            decoration: isActive
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: getMainAppTheme(context).colors.navBarColor,
                    border: Border.all(color: getMainAppTheme(context).colors.bgColor, width: 2))
                : null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isActive) const SizedBox(height: 8),
                SvgPicture.asset(widget.icon,
                    color: isActive
                        ? getMainAppTheme(context).colors.activeColor
                        : getMainAppTheme(context).colors.inactiveColor),
                if (!isActive) ...[
                  const SizedBox(height: 4),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: getMainAppTheme(context).textStyles.caption.copyWith(
                        color: isActive
                            ? getMainAppTheme(context).colors.activeText
                            : getMainAppTheme(context).colors.inactiveText),
                  ).tr()
                ]
              ],
            ),
          );
        }),
      ),
    );
  }
}

//для статичного боттом бара с вырезом по центру 
// final paint = Paint()
//   ..color = Colors.white
//   ..style = PaintingStyle.fill;
// final path = Path()
//   ..moveTo(0, 20)
//   ..quadraticBezierTo(size.width * 0.2, 0, size.width * 0.35, 0)
//   ..quadraticBezierTo(size.width * 0.4, 0, size.width * 0.4, 20)
//   ..arcToPoint(Offset(size.width * 0.55, 20), radius: Radius.circular(20.0), clockwise: false)
//   ..quadraticBezierTo(size.width * 0.55, 0, size.width * 0.6, 0)
//   ..quadraticBezierTo(size.width * 0.75, 0, size.width, 20)
//   ..lineTo(size.width, size.height)
//   ..lineTo(0, size.height)
//   ..lineTo(0, 20);
// canvas.drawShadow(path, Colors.black, 5, true);
// canvas.drawPath(path, paint);