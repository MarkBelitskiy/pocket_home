import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';

class AnimatedOverlayWidget extends StatefulWidget {
  const AnimatedOverlayWidget(
      {super.key,
      required this.childKeys,
      required this.child,
      required this.layerLink,
      required this.activateAnimation});
  final bool activateAnimation;
  final Widget child;
  final List<GlobalKey> childKeys;
  final LayerLink layerLink;

  @override
  State<AnimatedOverlayWidget> createState() => _AnimatedOverlayWidgetState();
}

class _AnimatedOverlayWidgetState extends State<AnimatedOverlayWidget> {
  OverlayEntry? _overlayEntry;
  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.activateAnimation) {
        showOverlay.call(
          context,
          0,
        );
      }
    });

    return widget.child;
  }

  void showOverlay(BuildContext context, int step) {
    _overlayEntry = createOverlayEntry(step);

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void hideOverlay(BuildContext context) {
    _overlayEntry?.remove();
  }

  Offset? getPosition(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero).translate(0, 60);
    return position;
  }

  OverlayEntry createOverlayEntry(int step) => OverlayEntry(
        builder: (BuildContext context) => Stack(
          children: [
            _AnimatedOverlay(childKey: widget.childKeys[step], layerLink: widget.layerLink),
            Positioned.fill(
              child: UnconstrainedBox(
                child: CompositedTransformFollower(
                  offset: getPosition(widget.childKeys[step]) ?? const Offset(0, 0),
                  link: widget.layerLink,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 64),
                    decoration: BoxDecoration(
                        color: getMainAppTheme(context).colors.cardColor, borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step == 1 ? "showcaseTitle1" : "showcaseTitle2",
                          style: getMainAppTheme(context)
                              .textStyles
                              .title
                              .copyWith(color: getMainAppTheme(context).colors.activeColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ).tr(),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(step == 1 ? "showcaseMsg1" : "showcaseMsg2",
                                style: getMainAppTheme(context)
                                    .textStyles
                                    .body
                                    .copyWith(color: getMainAppTheme(context).colors.mainTextColor))
                            .tr(),
                        const SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (step == 0) {
                              hideOverlay(context);
                              showOverlay.call(context, 1);
                            } else {
                              hideOverlay(context);
                            }
                          },
                          child: Row(
                            children: [
                              Text("step",
                                      style: getMainAppTheme(context)
                                          .textStyles
                                          .body
                                          .copyWith(color: getMainAppTheme(context).colors.inactiveText))
                                  .tr(args: [(step + 1).toString()]),
                              const Spacer(),
                              Text(step == 1 ? "close" : "next",
                                      style: getMainAppTheme(context)
                                          .textStyles
                                          .body
                                          .copyWith(color: getMainAppTheme(context).colors.mainTextColor))
                                  .tr(),
                              const SizedBox(
                                width: 4,
                              ),
                              SvgPicture.asset(
                                step == 1
                                    ? getMainAppTheme(context).icons.close
                                    : getMainAppTheme(context).icons.chevronRight,
                                color: getMainAppTheme(context).colors.activeColor,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class RRectClipper extends CustomClipper<Path> {
  final bool isCircle;
  final BorderRadius? radius;
  final EdgeInsets overlayPadding;
  final Rect area;

  RRectClipper({
    this.isCircle = false,
    this.radius,
    this.overlayPadding = EdgeInsets.zero,
    this.area = Rect.zero,
  });

  @override
  Path getClip(Size size) {
    final customRadius = isCircle ? Radius.circular(area.height) : const Radius.circular(3.0);

    final rect = Rect.fromLTRB(
      area.left - overlayPadding.left,
      area.top - overlayPadding.top,
      area.right + overlayPadding.right,
      area.bottom + overlayPadding.bottom,
    );

    return Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(Offset.zero & size)
      ..addRRect(
        RRect.fromRectAndCorners(
          rect,
          topLeft: (radius?.topLeft ?? customRadius),
          topRight: (radius?.topRight ?? customRadius),
          bottomLeft: (radius?.bottomLeft ?? customRadius),
          bottomRight: (radius?.bottomRight ?? customRadius),
        ),
      );
  }

  @override
  bool shouldReclip(covariant RRectClipper oldClipper) =>
      isCircle != oldClipper.isCircle ||
      radius != oldClipper.radius ||
      overlayPadding != oldClipper.overlayPadding ||
      area != oldClipper.area;
}

class _AnimatedOverlay extends StatefulWidget {
  const _AnimatedOverlay({required this.childKey, required this.layerLink});
  final GlobalKey childKey;
  final LayerLink layerLink;
  @override
  State<_AnimatedOverlay> createState() => _AnimatedOverlayState();
}

class _AnimatedOverlayState extends State<_AnimatedOverlay> with SingleTickerProviderStateMixin {
  double scale = 0;

  AnimationController? controller;
  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
      lowerBound: 0,
      upperBound: 10,
    )
      ..forward(from: 1)
      ..addListener(() {
        setState(
          () {
            scale = controller!.value;
          },
        );
        if (controller!.isCompleted) {
          controller!.animateBack(1).then((value) {
            controller?.forward();
          });
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller!,
      builder: (context, child) {
        return ClipPath(
          clipper: RRectClipper(area: _getOffset(widget.childKey), radius: BorderRadius.circular(12)),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 0.1,
              sigmaY: 0.1,
            ),
            child: Container(
              color: Colors.black45.withOpacity(0.75),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        );
      },
    );
  }

  Rect _getOffset(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);
    Offset? topLeft;
    Offset? bottomRight;
    if (position != null) {
      topLeft = box?.size.topLeft(position.translate(0 - scale, 0 - scale));
      bottomRight = box?.size.bottomRight(position.translate(0 + scale, 0 + scale));
    }

    return Rect.fromPoints(topLeft ?? const Offset(0, 0), bottomRight ?? const Offset(0, 0));
  }
}
