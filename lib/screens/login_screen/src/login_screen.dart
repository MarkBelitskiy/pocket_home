part of '../feature.dart';

class _LoginScreen extends StatelessWidget {
  const _LoginScreen({super.key, required this.mainScreenBloc});
  final MainScreenBloc mainScreenBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: getMainAppTheme(context).colors.bgColor,
      appBar: const MainAppBar(
        title: 'Авторизация',
      ),
      body: MainAppBody(children: [
        _Body(
          mainScreenBloc: mainScreenBloc,
        )
      ]),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key, required this.mainScreenBloc});
  final MainScreenBloc mainScreenBloc;
  @override
  Widget build(BuildContext context) {
    TextEditingController loginController = TextEditingController();
    TextEditingController passController = TextEditingController();
    FocusNode loginFocus = FocusNode();
    FocusNode passFocus = FocusNode();
    return BlocConsumer<LoginScreenBloc, LoginScreenState>(
      listener: (context, state) {
        if (state is AuthorizedSuccessState) {
          Navigator.of(context).pop();
          context.read<MyHousesBloc>().add(InitHousesEvent());
          mainScreenBloc.add(OnInitAppEvent());
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            MainTextField(
                title: 'Логин',
                textController: loginController,
                focusNode: loginFocus,
                bgColor: getMainAppTheme(context).colors.cardColor,
                isPasswordField: false,
                maxLines: 1,
                readOnly: false,
                onChanged: (value) {},
                clearAvailable: true,
                autoFocus: false),
            const SizedBox(
              height: 24,
            ),
            MainTextField(
                title: 'Пароль',
                textController: passController,
                focusNode: passFocus,
                bgColor: getMainAppTheme(context).colors.cardColor,
                isPasswordField: true,
                maxLines: 1,
                readOnly: false,
                onChanged: (value) {},
                clearAvailable: false,
                autoFocus: false),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(forgotPassScreenFeature());
              },
              child: Text(
                'Забыли пароль?',
                style: getMainAppTheme(context).textStyles.body.copyWith(
                      color: ColorPalette.red500,
                    ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            MainAppButton(
                onPressed: () {
                  context.read<LoginScreenBloc>().add(LoginEvent(loginController.text, passController.text));
                },
                title: 'Продолжить',
                titleColor: ColorPalette.blue200,
                assetIcon: '')
          ],
        );
      },
    );
  }
}
