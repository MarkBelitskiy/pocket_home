part of '../feature.dart';

class _MainScreen extends StatelessWidget {
  const _MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UserIsNotAuthorizedState) {
              context.read<MainScreenViewModel>().changeScreen(0);
            }
          },
          buildWhen: (previous, current) => current is AuthorizedSuccessState || current is UserIsNotAuthorizedState,
          builder: (context, state) {
            if (state is AuthorizedSuccessState) {
              return const Scaffold(body: _Body(), extendBody: true, bottomNavigationBar: CustomNavBar());
            }
            if (state is UserIsNotAuthorizedState) {
              return const _UserNotLoadedScreen();
            }
            return const _SplashScreen();
          },
        ));
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenViewModel>(
      builder: (context, value, child) => Stack(
        children: [
          IndexedStack(
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
                onGenerateRoute: (route) => CupertinoPageRoute(
                    settings: route,
                    builder: (context) {
                      return const MyHousesScreanFeature();
                    }),
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
        ],
      ),
    );
  }
}

class _UserNotLoadedScreen extends StatefulWidget {
  const _UserNotLoadedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<_UserNotLoadedScreen> createState() => _UserNotLoadedScreenState();
}

class _UserNotLoadedScreenState extends State<_UserNotLoadedScreen> {
  double opacity = 0.0;
  double opacityButtons = 0.0;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000))
        .then(
      (value) => setState(() {
        opacity = 1;
      }),
    )
        .then((value) {
      Future.delayed(const Duration(milliseconds: 500)).then(
        (value) => setState(() {
          opacityButtons = 1;
        }),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: getMainAppTheme(context).colors.bgColor,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: SvgPicture.asset(
                getMainAppTheme(context).icons.splashBg,
                fit: BoxFit.fill,
                height: size.height,
                width: size.width,
              ),
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 6,
                    ),
                    AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(milliseconds: 1500),
                      child: SvgPicture.asset(
                        getMainAppTheme(context).icons.splashLogo,
                      ),
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    AnimatedOpacity(
                      opacity: opacityButtons,
                      duration: const Duration(seconds: 1),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
                        child: MainAppButton(
                          onPressed: () {
                            Navigator.of(context).push(loginScreenFeature());
                          },
                          title: 'enter',
                          titleColor: getMainAppTheme(context).colors.activeColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    AnimatedOpacity(
                      opacity: opacityButtons,
                      duration: const Duration(seconds: 1),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 1.4),
                        child: MainAppButton(
                          onPressed: () {
                            Navigator.of(context).push(registrationScreenFeature());
                          },
                          titleColor: getMainAppTheme(context).colors.activeColor,
                          title: 'register',
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

class _SplashScreen extends StatelessWidget {
  const _SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getMainAppTheme(context).colors.bgColor,
      body: Center(
        child: SvgPicture.asset(
          getMainAppTheme(context).icons.splashLogo,
        ),
      ),
    );
  }
}
