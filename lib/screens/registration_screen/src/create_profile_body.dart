part of '../feature.dart';

class _CreateProfileBody extends StatelessWidget {
  const _CreateProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CreatePasswordModel>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: Column(
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
              bgColor: getMainAppTheme(context).colors.cardColor,
              isPasswordField: false,
              maxLines: 1,
              readOnly: false,
              onChanged: (value) {},
              clearAvailable: true,
              title: 'Логин',
              autoFocus: false),
          const SizedBox(
            height: 32,
          ),
          MainTextField(
              textController: vm.nameTextController,
              focusNode: vm.nameFocus,
              bgColor: getMainAppTheme(context).colors.cardColor,
              isPasswordField: false,
              maxLines: 1,
              readOnly: false,
              onChanged: (value) {},
              clearAvailable: true,
              title: 'ФИО',
              autoFocus: false),
          const SizedBox(
            height: 32,
          ),
          MainTextField(
              textController: vm.phoeTextController,
              focusNode: vm.phoneFocus,
              bgColor: getMainAppTheme(context).colors.cardColor,
              isPasswordField: false,
              maxLines: 1,
              keyboardType: TextInputType.phone,
              readOnly: false,
              onChanged: (value) {},
              clearAvailable: true,
              title: 'Телефон',
              autoFocus: false),
          const SizedBox(
            height: 32,
          ),
          MainAppButton(
              onPressed: () {
                context.read<RegisterBloc>().add(ChangeBodyEvent(RegisterScreenBodyEnums.password));
              },
              titleColor: ColorPalette.blue200,
              title: 'Продолжить',
              assetIcon: '')
        ],
      ),
    );
  }
}
