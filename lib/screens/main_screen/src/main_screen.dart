part of '../feature.dart';

class _MainScreen extends StatelessWidget {
  const _MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
      child: Consumer<MainAppLocaleViewModel>(builder: (context, value, child) {
        return BlocConsumer<MainScreenBloc, MainScreenState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is UserSuccessLoadedState) {
              return Scaffold(
                body: const _Body(),
                backgroundColor: getMainAppTheme(context).colors.buttonsColor,
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
                  color: getMainAppTheme(context).colors.cardColor,
                  buttonBackgroundColor: getMainAppTheme(context).colors.cardColor,
                  backgroundColor: context.watch<MainScreenViewModel>().activeIndex == 4
                      ? getMainAppTheme(context).colors.buttonsColor
                      : getMainAppTheme(context).colors.bgColor,
                  animationCurve: Curves.fastLinearToSlowEaseIn,
                  animationDuration: const Duration(milliseconds: 300),
                  onTap: (index) {
                    context.read<MainScreenViewModel>().changeScreen(index);
                  },
                  letIndexChange: (index) => true,
                ),
              );
            }
            return _SplashScreen();
          },
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
            onGenerateRoute: (route) =>
                CupertinoPageRoute(settings: route, builder: (context) => const NewsScreenFeature()),
          ),
          Navigator(
            key: value.navigatorKeys[1],
            onGenerateRoute: (route) =>
                CupertinoPageRoute(settings: route, builder: (context) => const ServicesScreenFeature()),
          ),
          Navigator(
            key: value.navigatorKeys[2],
            onGenerateRoute: (route) =>
                CupertinoPageRoute(settings: route, builder: (context) => const ChatScreenFeature()),
          ),
          Navigator(
            key: value.navigatorKeys[3],
            onGenerateRoute: (route) =>
                CupertinoPageRoute(settings: route, builder: (context) => const ReportsScreenFeature()),
          ),
          Navigator(
              key: value.navigatorKeys[4],
              onGenerateRoute: (route) =>
                  CupertinoPageRoute(settings: route, builder: (context) => const ProfileScreenFeature())),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({Key? key, required this.icon, required this.index, this.secondIcon, required this.title})
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

class _SplashScreen extends StatefulWidget {
  const _SplashScreen({super.key});

  @override
  State<_SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<_SplashScreen> {
  double opacity = 0.0;
  double opacityButtons = 0.0;
  @override
  void initState() {
    if (!mounted) {
      Future.delayed(const Duration(milliseconds: 1000))
          .then((value) => setState(() {
                opacity = 1;
              }))
          .then((value) {
        Future.delayed(const Duration(milliseconds: 500)).then((value) => setState(() {
              opacityButtons = 1;
            }));
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getMainAppTheme(context).colors.bgColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/icons/splash_bg.svg",
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              right: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 6,
                    ),
                    AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(milliseconds: 1500),
                      child: SvgPicture.asset(
                        'assets/icons/splash_logo.svg',
                        // fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    AnimatedOpacity(
                      opacity: opacityButtons,
                      duration: const Duration(seconds: 1),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(loginScreenFeature(context.read<MainScreenBloc>()));
                        },
                        color: getMainAppTheme(context).colors.buttonsColor,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 64),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Войти',
                          textAlign: TextAlign.center,
                          style: getMainAppTheme(context).textStyles.title.copyWith(color: ColorPalette.blue200),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    AnimatedOpacity(
                      opacity: opacityButtons,
                      duration: const Duration(seconds: 1),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(registrationScreenFeature());
                        },
                        color: getMainAppTheme(context).colors.bgColor,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: getMainAppTheme(context).colors.buttonsColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Зарегистрироваться',
                          textAlign: TextAlign.center,
                          style: getMainAppTheme(context).textStyles.title.copyWith(color: ColorPalette.blue200),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


  // @override
  // void initState() {
  //   top = bottom = 250;
  //   Future.delayed(Duration(seconds: 1)).then((value) {
  //     Future.delayed(Duration(milliseconds: 300)).then((value) {
  //       setState(() {
  //         top = 0;
  //       });
  //     });
  //     setState(() {
  //       bottom = 0;
  //     });
  //   });
  //   super.initState();
  // }

