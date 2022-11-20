part of '../feature.dart';

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        body: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(
                getMainAppTheme(context).icons.emptySingleBlob,
                width: MediaQuery.of(context).size.width,
              )),
          Positioned(
            bottom: 0,
            top: 50,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const _MainInfoWidget(),
                    MainAppButton(
                      onPressed: () {},
                      title: 'myBuildings'.tr(),
                      assetIcon: getMainAppTheme(context).icons.myBuildings,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MainAppButton(
                      onPressed: () {
                        context
                            .read<MainAppLocaleViewModel>()
                            .changeLocale(context);
                      },
                      title: 'localeLanguage'.tr(),
                      assetIcon: getMainAppTheme(context).icons.earth,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MainAppButton(
                      onPressed: () {},
                      title: 'settings'.tr(),
                      assetIcon: getMainAppTheme(context).icons.settings,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'deleteAccount'.tr(),
                        textAlign: TextAlign.center,
                        style: getMainAppTheme(context)
                            .textStyles
                            .title
                            .copyWith(
                                color: getMainAppTheme(context)
                                    .colors
                                    .errorTextColor),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'logout'.tr(),
                        textAlign: TextAlign.center,
                        style: getMainAppTheme(context)
                            .textStyles
                            .title
                            .copyWith(
                                color:
                                    getMainAppTheme(context).colors.activeText),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class _MainInfoWidget extends StatelessWidget {
  const _MainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 75,
              backgroundColor: getMainAppTheme(context).colors.cardColor,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  'assets/images/app_launch_image.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
                bottom: 5,
                left: 0,
                right: 0,
                child: SvgPicture.asset(
                  getMainAppTheme(context).icons.camera,
                  width: 32,
                  height: 32,
                  color: getMainAppTheme(context).colors.mainTextColor,
                ))
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'MRKBL',
          textAlign: TextAlign.center,
          style: getMainAppTheme(context)
              .textStyles
              .title
              .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Марк Белицкий',
          textAlign: TextAlign.center,
          style: getMainAppTheme(context)
              .textStyles
              .title
              .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              getMainAppTheme(context).icons.phone,
              color: getMainAppTheme(context).colors.mainTextColor,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              '+7 777 777 ** **',
              textAlign: TextAlign.center,
              style: getMainAppTheme(context).textStyles.title.copyWith(
                  color: getMainAppTheme(context).colors.mainTextColor),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
