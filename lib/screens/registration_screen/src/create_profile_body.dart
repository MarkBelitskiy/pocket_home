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
            context.read<RegisterBloc>().add(ChangeBodyEvent(RegisterScreenBodyEnums.password));
          },
          titleColor: ColorPalette.blue200,
          title: 'continue',
        )
      ],
    );
  }
}
