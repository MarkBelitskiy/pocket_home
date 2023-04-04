part of '../feature.dart';

class _ForgotPassScreen extends StatelessWidget {
  const _ForgotPassScreen();

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final focus = FocusNode();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: getMainAppTheme(context).colors.bgColor,
      appBar: const MainAppBar(title: 'passwordReset'),
      body: MainAppBody(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 6,
        ),
        MainTextField(
          title: 'phone',
          textController: controller,
          focusNode: focus,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(
          height: 24,
        ),
        MainAppButton(
            onPressed: () {
              Navigator.of(context).push(otpScreenRoute(controller.text, (callback) {
                Navigator.of(context).push(resetPasswordScreenFeature());
              }));
            },
            title: 'continue',
            titleColor: ColorPalette.blue200,
            assetIcon: ''),
        const SizedBox(
          height: 32,
        ),
        GestureDetector(
          onTap: () {
            //TODO ADD BOT OR REDIRECT LINK TO TELEGRAM
          },
          child: Text(
            'writeToTechPod',
            style: getMainAppTheme(context).textStyles.body.copyWith(
                  color: ColorPalette.red500,
                ),
          ).tr(),
        ),
      ]),
    );
  }
}
