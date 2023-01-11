part of '../feature.dart';

class _LoginScreen extends StatelessWidget {
  const _LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getMainAppTheme(context).colors.bgColor,
      appBar: const MainAppBar(
        title: 'Авторизация',
      ),
      body: const MainAppBody(isDoubleBlob: false, children: [_Body()]),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 6,
        ),
        MainTextField(
            title: 'Логин',
            textController: TextEditingController(),
            focusNode: FocusNode(),
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
            textController: TextEditingController(),
            focusNode: FocusNode(),
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
            onPressed: () {},
            title: 'Продолжить',
            titleColor: ColorPalette.blue200,
            assetIcon: '')
      ],
    );
  }
}
