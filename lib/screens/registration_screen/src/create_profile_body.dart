part of '../feature.dart';

class _CreateProfileBody extends StatelessWidget {
  const _CreateProfileBody();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CreatePasswordModel>(context);
    return MainAppBody(
      children: [
        MainAppFilePicker(
          maxFiles: 1,
          onFilesAddedCallBack: (callback) {
            vm.photoPath = callback.first;
          },
          isProfilePhotoWidget: true,
        ),
        const SizedBox(
          height: 32,
        ),
        MainTextField(
          textController: vm.loginTextController,
          focusNode: vm.loginFocus,
          title: 'login',
        ),
        const SizedBox(
          height: 32,
        ),
        MainTextField(
          textController: vm.nameTextController,
          focusNode: vm.nameFocus,
          title: 'fullName',
        ),
        const SizedBox(
          height: 32,
        ),
        MainTextField(
          textController: vm.phoeTextController,
          focusNode: vm.phoneFocus,
          keyboardType: TextInputType.phone,
          title: 'phone',
        ),
        const SizedBox(
          height: 32,
        ),
        MainAppButton(
          onPressed: () {
            if (vm.loginTextController.text.isEmpty) {
              return returnSnackBar(context, 'fillInLogginField');
            }
            if (vm.nameTextController.text.isEmpty) {
              return returnSnackBar(context, 'fillInFullNameField');
            }
            if (vm.phoeTextController.text.isEmpty || vm.phoeTextController.text.replaceAll(' ', '').length < 14) {
              return returnSnackBar(context, 'fillInPhoneField');
            }
            context.read<RegisterBloc>().add(ChangeBodyEvent(RegisterScreenBodyEnums.password));
          },
          titleColor: getMainAppTheme(context).colors.accentTextColor,
          title: 'continue',
        )
      ],
    );
  }
}
