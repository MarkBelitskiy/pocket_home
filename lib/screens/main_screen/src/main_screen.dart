part of '../feature.dart';

class _MainScreen extends StatelessWidget {
  const _MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light
          .copyWith(statusBarColor: Colors.transparent),
      child: Consumer<MainAppLocaleViewModel>(builder: (context, value, child) {
        return Scaffold(
          body: const _Body(),
          backgroundColor: getMainAppTheme(context).colors.bgColor,
          bottomNavigationBar: CurvedNavigationBar(
            key: bottomNavigationKey,
            items: <Widget>[
              _NavBarItem(
                icon: getMainAppTheme(context).icons.news,
                title: 'news'.tr(),
                index: 0,
              ),
              _NavBarItem(
                icon: getMainAppTheme(context).icons.services,
                title: 'services'.tr(),
                index: 1,
              ),
              _NavBarItem(
                icon: getMainAppTheme(context).icons.chatUnActive,
                secondIcon: getMainAppTheme(context).icons.chatActive,
                title: 'chat'.tr(),
                index: 2,
              ),
              _NavBarItem(
                icon: getMainAppTheme(context).icons.reports,
                title: 'reports'.tr(),
                index: 3,
              ),
              _NavBarItem(
                icon: getMainAppTheme(context).icons.profile,
                title: 'profile'.tr(),
                index: 4,
              ),
            ],
            color: const Color(0xff374151),
            buttonBackgroundColor: const Color(0xff374151),
            backgroundColor:
                context.watch<MainScreenViewModel>().activeIndex == 4
                    ? getMainAppTheme(context).colors.buttonsColor
                    : getMainAppTheme(context).colors.bgColor,
            animationCurve: Curves.easeInOutCubic,
            animationDuration: const Duration(milliseconds: 400),
            onTap: (index) {
              context.read<MainScreenViewModel>().changeScreen(index);
            },
            letIndexChange: (index) => true,
          ),
        );
      }),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenViewModel>(
      builder: (context, value, child) => IndexedStack(
        index: value.activeIndex,
        children: <Widget>[
          Navigator(
            key: value.navigatorKeys[0],
            onGenerateRoute: (route) => CupertinoPageRoute(
                settings: route,
                builder: (context) => const NewsScreenFeature()),
          ),
          Navigator(
            key: value.navigatorKeys[1],
            onGenerateRoute: (route) => CupertinoPageRoute(
                settings: route,
                builder: (context) => const ServicesScreenFeature()),
          ),
          Navigator(
            key: value.navigatorKeys[2],
            onGenerateRoute: (route) => CupertinoPageRoute(
                settings: route,
                builder: (context) => const ChatScreenFeature()),
          ),
          Navigator(
            key: value.navigatorKeys[3],
            onGenerateRoute: (route) => CupertinoPageRoute(
                settings: route,
                builder: (context) => const ReportsScreenFeature()),
          ),
          Navigator(
              key: value.navigatorKeys[4],
              onGenerateRoute: (route) => CupertinoPageRoute(
                  settings: route,
                  builder: (context) => const ProfileScreenFeature())),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem(
      {Key? key,
      required this.icon,
      required this.index,
      this.secondIcon,
      required this.title})
      : super(key: key);
  final String icon;
  final int index;
  final String? secondIcon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenViewModel>(builder: (context, value, child) {
      bool isActive = value.activeIndex == index;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isActive) const SizedBox(height: 8),
          SvgPicture.asset(isActive ? secondIcon ?? icon : icon,
              color: isActive
                  ? getMainAppTheme(context).colors.activeColor
                  : getMainAppTheme(context).colors.inactiveColor),
          if (!isActive) ...[
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: getMainAppTheme(context).textStyles.caption.copyWith(
                  color: isActive
                      ? getMainAppTheme(context).colors.activeText
                      : getMainAppTheme(context).colors.inactiveText),
            )
          ]
        ],
      );
    });
  }
}
