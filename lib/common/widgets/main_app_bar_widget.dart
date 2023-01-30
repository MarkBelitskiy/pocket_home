import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar(
      {super.key, required this.title, this.actions, this.customOnTap, this.tabNames, this.leadingEnable = true});
  final String title;
  final List<Widget>? actions;
  final Function? customOnTap;
  final List<String>? tabNames;
  final bool leadingEnable;
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
        style: getMainAppTheme(context).textStyles.title.copyWith(color: getMainAppTheme(context).colors.mainTextColor),
      ),
      leading: leadingEnable
          ? IconButton(
              onPressed: () {
                if (customOnTap != null) {
                  customOnTap!.call();
                } else {
                  Navigator.of(context).pop();
                }
              },
              icon: SvgPicture.asset(
                getMainAppTheme(context).icons.chevronLeft,
                color: getMainAppTheme(context).colors.mainTextColor,
              ),
            )
          : null,
      bottom: tabNames != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: _BottomTabBar(
                tabNames: tabNames!,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _BottomTabBar extends StatelessWidget {
  final List<String> tabNames;
  final List<Function>? tabsLogs;
  const _BottomTabBar({Key? key, required this.tabNames, this.tabsLogs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 34,
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: getMainAppTheme(context).colors.cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: TabBar(
              labelColor: Colors.white,
              unselectedLabelStyle: getMainAppTheme(context).textStyles.body,
              unselectedLabelColor: ColorPalette.grey900,
              labelStyle: getMainAppTheme(context).textStyles.body,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(color: ColorPalette.grey700, borderRadius: BorderRadius.circular(6), boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 1),
                  blurRadius: 4,
                ),
              ]),
              tabs: tabNames
                  .map((name) => GestureDetector(
                      onTap: () {
                        if (tabsLogs != null) {
                          tabsLogs![tabNames.indexOf(name)].call();
                        }
                        DefaultTabController.of(context)!.animateTo(tabNames.indexOf(name));
                      },
                      child: Tab(text: name)))
                  .toList()),
        ),
      ],
    );
  }
}
