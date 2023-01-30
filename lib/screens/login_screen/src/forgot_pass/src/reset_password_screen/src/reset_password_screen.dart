part of '../feature.dart';

class _ResetPasswordScreen extends StatelessWidget {
  const _ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: getMainAppTheme(context).colors.bgColor,
      appBar: const MainAppBar(
        title: 'Восстановление пароля',
      ),
      body: const MainAppBody(
          isDoubleBlob: false, children: [_ResetPasswordBody()]),
    );
  }
}

class _ResetPasswordBody extends StatelessWidget {
  const _ResetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ResetPasswordModel>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: Column(
        children: [
          StreamBuilder<bool>(
            stream: vm.getValidateAllWithoutCheckForSame,
            initialData: false,
            builder: (context, snapshot) => MainTextField(
                textController: vm.passwordTextController,
                focusNode: vm.passwordFocusNode,
                bgColor: getMainAppTheme(context).colors.cardColor,
                isPasswordField: true,
                maxLines: 1,
                readOnly: false,
                onChanged: (value) {},
                clearAvailable: false,
                title: 'Пароль',
                borderColors: snapshot.hasData && snapshot.data!
                    ? ColorPalette.green500
                    : vm.passwordFocusNode.hasFocus ||
                            vm.passwordTextController.text.isEmpty
                        ? null
                        : ColorPalette.red500,
                errorText: (snapshot.hasData && snapshot.data! ||
                        vm.passwordFocusNode.hasFocus)
                    ? null
                    : vm.passwordTextController.text.isNotEmpty
                        ? 'Введенный пароль не соответствует требованиям'
                        : null,
                autoFocus: false),
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
                bgColor: getMainAppTheme(context).colors.cardColor,
                isPasswordField: true,
                maxLines: 1,
                borderColors: vm.passwordRepeatTextController.text.isNotEmpty &&
                        snapshot.hasData &&
                        snapshot.data!
                    ? ColorPalette.green500
                    : vm.passwordRepeatTextController.text.isEmpty ||
                            vm.passwordRepeatFocusNode.hasFocus
                        ? null
                        : ColorPalette.red500,
                errorText: (snapshot.hasData && snapshot.data!)
                    ? null
                    : vm.passwordRepeatTextController.text.isNotEmpty
                        ? 'Пароли не совпадают'
                        : '',
                readOnly: false,
                onChanged: (value) {},
                clearAvailable: false,
                title: 'Повторите пароль',
                autoFocus: false),
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
                          child: Text('Длина пароля - не менее 8 символов;',
                              style: getMainAppTheme(context)
                                  .textStyles
                                  .body
                                  .copyWith(color: ColorPalette.green500)),
                        )
                      ],
                    )
                  : Text('\u2022 Длина пароля - не менее 8 символов;',
                      style: getMainAppTheme(context)
                          .textStyles
                          .body
                          .copyWith(color: ColorPalette.grey500));
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
                          child: Text(
                              'Состоит из букв латинского алфавита (A-z), арабских цифр (0-9)',
                              style: getMainAppTheme(context)
                                  .textStyles
                                  .body
                                  .copyWith(color: ColorPalette.green500)),
                        )
                      ],
                    )
                  : Text(
                      '\u2022 Состоит из букв латинского алфавита (A-z), арабских цифр (0-9)',
                      style: getMainAppTheme(context)
                          .textStyles
                          .body
                          .copyWith(color: ColorPalette.grey500));
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
                          child: Text(
                              'Буквенная часть пароля содержит прописные (заглавные) и строчные буквы.',
                              style: getMainAppTheme(context)
                                  .textStyles
                                  .body
                                  .copyWith(color: ColorPalette.green500)),
                        )
                      ],
                    )
                  : Text(
                      '\u2022 Буквенная часть пароля содержит прописные (заглавные) и строчные буквы.',
                      style: getMainAppTheme(context)
                          .textStyles
                          .body
                          .copyWith(color: ColorPalette.grey500));
            },
          ),
          const SizedBox(height: 24),
          StreamBuilder<bool>(
              stream: vm.getValidateAll,
              initialData: false,
              builder: (context, snapshot) => MainAppButton(
                  onPressed: () {},
                  titleColor: ColorPalette.blue200,
                  title: 'Продолжить',
                  assetIcon: ''))
        ],
      ),
    );
  }
}
