part of '../feature.dart';

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainAppThemeViewModel>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) => current is ProfileLoadedState,
      builder: (context, state) {
        if (state is ProfileLoadedState) {
          return MainAppBody(
            children: [
              _MainInfoWidget(profile: state.profile),
              const SizedBox(
                height: 16,
              ),
              MainAppButton(
                onPressed: () {
                  context.read<MainAppLocaleViewModel>().changeLocale(context);
                },
                title: 'localeLanguage',
                assetIcon: getMainAppTheme(context).icons.earth,
              ),
              const SizedBox(
                height: 16,
              ),
              MainAppButton(
                onPressed: () async {
                  context.read<MainAppThemeViewModel>().changeTheme();
                },
                title: 'changeAppTheme'.tr(),
                assetIcon: getMainAppTheme(context).icons.settings,
              ),
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  context.read<AuthBloc>().add(DeleteAccountEvent(state.profile));
                },
                child: Text(
                  'deleteAccount',
                  textAlign: TextAlign.center,
                  style: getMainAppTheme(context).textStyles.title.copyWith(color: ColorPalette.red500),
                ).tr(),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  context.read<AuthBloc>().add(LogOutEvent());
                },
                child: Text(
                  'logout',
                  textAlign: TextAlign.center,
                  style: getMainAppTheme(context)
                      .textStyles
                      .title
                      .copyWith(color: getMainAppTheme(context).colors.activeText),
                ).tr(),
              ),
            ],
          );
        }
        if (state is ProfileLoadedErrorState) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: EmptyPlaceholderWithLottie(
                    lottiePath: getMainAppTheme(context).icons.profileLottie,
                    margin: const EdgeInsets.only(bottom: 110, left: 20),
                    title: 'cantLoadingProfile',
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _MainInfoWidget extends StatelessWidget {
  const _MainInfoWidget({required this.profile});
  final UserModel profile;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainAppFilePicker(
          maxFiles: 1,
          onFilesAddedCallBack: (values) {
            profile.photoPath = values.first;
            context.read<ProfileBloc>().add(UpdateProfileEvent(profile));
          },
          isProfilePhotoWidget: true,
          profilePhotoPath: profile.photoPath,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          profile.name,
          textAlign: TextAlign.center,
          style:
              getMainAppTheme(context).textStyles.title.copyWith(color: getMainAppTheme(context).colors.textOnBgColor),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              getMainAppTheme(context).icons.phone,
              color: getMainAppTheme(context).colors.textOnBgColor,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              profile.phone,
              textAlign: TextAlign.center,
              style: getMainAppTheme(context)
                  .textStyles
                  .title
                  .copyWith(color: getMainAppTheme(context).colors.textOnBgColor),
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
