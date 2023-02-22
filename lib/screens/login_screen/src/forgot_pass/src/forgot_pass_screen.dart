part of '../feature.dart';

class _ForgotPassScreen extends StatelessWidget {
  const _ForgotPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: getMainAppTheme(context).colors.bgColor,
      appBar: const MainAppBar(title: 'Восстановление пароля'),
      body: const MainAppBody(children: [_Body()]),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 6,
        ),
        MainTextField(
            title: 'Телефон',
            textController: controller,
            focusNode: FocusNode(),
            keyboardType: TextInputType.phone,
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
        MainAppButton(
            onPressed: () {
              Navigator.of(context).push(otpScreenRoute(controller.text, (callback) {
                Navigator.of(context).push(resetPasswordScreenFeature());
              }));
            },
            title: 'Продолжить',
            titleColor: ColorPalette.blue200,
            assetIcon: ''),
        const SizedBox(
          height: 32,
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Написать в тех.поддержку',
            style: getMainAppTheme(context).textStyles.body.copyWith(
                  color: ColorPalette.red500,
                ),
          ),
        ),
      ],
    );
  }
}
