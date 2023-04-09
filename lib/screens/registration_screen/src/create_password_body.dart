part of '../feature.dart';

class _CreatePasswordBody extends StatelessWidget {
  const _CreatePasswordBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CreatePasswordModel>(context);
    return MainAppBody(
      children: [
        MainTextField(
          textController: vm.passwordTextController,
          focusNode: vm.passwordFocusNode,
          isPasswordField: true,
          clearAvailable: false,
          title: 'pass',
          errorText: 'passFieldError'.tr(),
          regExpToValidate: RegExp(r'(?=.*[0-9])(?=\S+$)(?=.*[A-z])(?=.*[A-Z]).{8,}'),
        ),
        const SizedBox(
          height: 32,
        ),
        MainTextField(
          textController: vm.passwordRepeatTextController,
          focusNode: vm.passwordRepeatFocusNode,
          isPasswordField: true,
          clearAvailable: false,
          errorText: 'passwordsIsNotMatch'.tr(),
          otherControllerToValidate: vm.passwordTextController,
          title: 'repeatPass',
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
                        child: Text('passCondition1',
                                style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.green500))
                            .tr(),
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
                        child: Text('passCondition2',
                                style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.green500))
                            .tr(),
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
                        child: Text('passCondition3',
                                style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.green500))
                            .tr(),
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
                    if (snapshot.data ?? false) {
                      context.read<RegisterBloc>().add(
                            CreateProfileEvent(
                              UserModel(
                                  name: vm.nameTextController.text,
                                  password: vm.passwordTextController.text,
                                  phone: vm.phoeTextController.text,
                                  photoPath: vm.photoPath,
                                  login: vm.loginTextController.text),
                            ),
                          );
                    } else {
                      returnSnackBar(context, 'passwordsIsNotMatch');
                    }
                  },
                  titleColor: ColorPalette.blue200,
                  title: 'continue',
                ))
      ],
    );
  }
}
