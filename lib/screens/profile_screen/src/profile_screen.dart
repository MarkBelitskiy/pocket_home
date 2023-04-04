part of '../feature.dart';

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false, backgroundColor: getMainAppTheme(context).colors.bgColor, body: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccessDeletedState || state is LogoutState) {
          context.read<MyHousesBloc>().add(ClearDataEvent());
        }
      },
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
              // const SizedBox(
              //   height: 16,
              // ),
              // MainAppButton(
              //   onPressed: () async {
              //     final file = await monthBudgetPdfGenerate();
              //     if (file != null)
              //       Navigator.of(context, rootNavigator: true)
              //           .push(MaterialPageRoute(builder: (context) => PdfTitlesScreen(path: file.path)));
              //   },
              //   title: 'settings'.tr(),
              //   assetIcon: getMainAppTheme(context).icons.settings,
              // ),
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  context.read<ProfileBloc>().add(OnDeleteAccountEvent());
                },
                child: Text(
                  'deleteAccount'.tr(),
                  textAlign: TextAlign.center,
                  style: getMainAppTheme(context)
                      .textStyles
                      .title
                      .copyWith(color: getMainAppTheme(context).colors.errorTextColor),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  context.read<ProfileBloc>().add(OnLogoutEvent());
                },
                child: Text(
                  'logout'.tr(),
                  textAlign: TextAlign.center,
                  style: getMainAppTheme(context)
                      .textStyles
                      .title
                      .copyWith(color: getMainAppTheme(context).colors.activeText),
                ),
              ),
            ],
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
              getMainAppTheme(context).textStyles.title.copyWith(color: getMainAppTheme(context).colors.mainTextColor),
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
              profile.phone,
              textAlign: TextAlign.center,
              style: getMainAppTheme(context)
                  .textStyles
                  .title
                  .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
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
