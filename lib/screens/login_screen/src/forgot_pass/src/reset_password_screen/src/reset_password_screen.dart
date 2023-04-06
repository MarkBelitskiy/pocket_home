part of '../feature.dart';

class _ResetPasswordScreen extends StatelessWidget {
  const _ResetPasswordScreen();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ResetPasswordModel>(context);
    return Scaffold(
      backgroundColor: getMainAppTheme(context).colors.bgColor,
      appBar: const MainAppBar(
        title: 'passwordReset',
      ),
      body: MainAppBody(children: [
        StreamBuilder<bool>(
          stream: vm.getValidateAllWithoutCheckForSame,
          initialData: false,
          builder: (context, snapshot) => MainTextField(
            textController: vm.passwordTextController,
            focusNode: vm.passwordFocusNode,
            isPasswordField: true,
            clearAvailable: false,
            title: 'pass',
            errorText: 'passFieldError'.tr(),
            regExpToValidate: RegExp(r'(?=.*[0-9])(?=\S+$)(?=.*[A-z])(?=.*[A-Z]).{8,}'),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        StreamBuilder<bool>(
          stream: vm.getPasswordsIsSame,
          initialData: false,
          builder: (context, snapshot) => MainTextField(
            textController: vm.passwordRepeatTextController,
            focusNode: vm.passwordRepeatFocusNode,
            isPasswordField: true,
            errorText: 'passwordsIsNotMatch'.tr(),
            regExpToValidate: RegExp('r^${vm.passwordTextController.text}'),
            clearAvailable: false,
            title: 'repeatPass',
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        StreamBuilder<bool>(
          stream: vm.getLengthHigherThen8,
          initialData: false,
          builder: (_, snapshot) {
            return snapshot.hasData && snapshot.data!
                ? Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/action_success.svg",
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text('passCondition1'.tr(),
                            style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.green500)),
                      )
                    ],
                  )
                : Text('\u2022 ${'passCondition1'.tr()}',
                    style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.grey500));
          },
        ),
        const SizedBox(height: 8),
        StreamBuilder<bool>(
          stream: vm.getContainsLatLettersAndNumbers,
          initialData: false,
          builder: (_, snapshot) {
            return snapshot.hasData && snapshot.data!
                ? Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/action_success.svg",
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text('passCondition2'.tr(),
                            style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.green500)),
                      )
                    ],
                  )
                : Text('\u2022 ${'passCondition2'.tr()}',
                    style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.grey500));
          },
        ),
        const SizedBox(height: 8),
        StreamBuilder<bool>(
          stream: vm.getHaveOneOrMoreCapitalLetter,
          initialData: false,
          builder: (_, snapshot) {
            return snapshot.hasData && snapshot.data!
                ? Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/action_success.svg",
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text('passCondition3'.tr(),
                            style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.green500)),
                      )
                    ],
                  )
                : Text('\u2022 ${'passCondition3'.tr()}',
                    style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.grey500));
          },
        ),
        const SizedBox(height: 24),
        StreamBuilder<bool>(
            stream: vm.getValidateAll,
            initialData: false,
            builder: (context, snapshot) => MainAppButton(
                onPressed: () {
//TODO FUNC
                },
                titleColor: ColorPalette.blue200,
                title: 'continue',
                assetIcon: ''))
      ]),
    );
  }
}
