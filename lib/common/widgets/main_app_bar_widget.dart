import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar(
      {super.key,
      this.title = '',
      this.actions,
      this.customOnTap,
      this.tabNames,
      this.isRoot = false,
      this.leadingEnable = true,
      this.subTitle});
  final String title;
  final bool isRoot;
  final String? subTitle;
  final List<Widget>? actions;
  final Function? customOnTap;
  final List<String>? tabNames;
  final bool leadingEnable;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      backgroundColor: getMainAppTheme(context).colors.navBarColor,
      elevation: 1,
      shadowColor: getMainAppTheme(context).colors.shadowColor,
      centerTitle: true,
      title: Column(
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: getMainAppTheme(context)
                  .textStyles
                  .title
                  .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
            ).tr(),
          if (subTitle != null) ...[
            const SizedBox(
              height: 4,
            ),
            Text(
              subTitle!,
              style: getMainAppTheme(context)
                  .textStyles
                  .subBody
                  .copyWith(color: getMainAppTheme(context).colors.inactiveText),
            ).tr(),
          ]
        ],
      ),
      leading: leadingEnable
          ? IconButton(
              onPressed: () {
                if (customOnTap != null) {
                  customOnTap!.call();
                } else {
                  Navigator.of(context, rootNavigator: isRoot).pop();
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

  const _BottomTabBar({
    Key? key,
    required this.tabNames,
  }) : super(key: key);

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
            color: getMainAppTheme(context).colors.tabActiveColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: TabBar(
              labelColor: getMainAppTheme(context).colors.mainTextColor,
              unselectedLabelStyle: getMainAppTheme(context).textStyles.body,
              unselectedLabelColor: getMainAppTheme(context).colors.inactiveText,
              labelStyle: getMainAppTheme(context).textStyles.body,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  color: getMainAppTheme(context).colors.tabBgColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: const Offset(0, 1),
                      blurRadius: 4,
                    ),
                  ]),
              tabs: tabNames
                  .map(
                    (name) => GestureDetector(
                      onTap: () {
                        DefaultTabController.of(context)!.animateTo(tabNames.indexOf(name));
                      },
                      child: Tab(
                        text: name.tr(),
                      ),
                    ),
                  )
                  .toList()),
        ),
      ],
    );
  }
}
