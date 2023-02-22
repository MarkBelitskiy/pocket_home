part of '../feature.dart';

class _AddNewWorkersScreen extends StatelessWidget {
  const _AddNewWorkersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<AddNewWorkersViewModel>();
    return Scaffold(
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        resizeToAvoidBottomInset: false,
        appBar: const MainAppBar(
          title: 'Добавление сотрудника',
          isRoot: true,
        ),
        body: MainAppBody(children: [
          const _ChooseJobTitleWidget(),
          const SizedBox(
            height: 16,
          ),
          MainTextField(
              textController: vm.fullNameController,
              focusNode: vm.fullNameFocusNode,
              bgColor: getMainAppTheme(context).colors.cardColor,
              isPasswordField: false,
              maxLines: null,
              readOnly: false,
              onChanged: (value) {},
              clearAvailable: true,
              title: 'ФИО',
              autoFocus: false),
          const SizedBox(
            height: 16,
          ),
          MainTextField(
              textController: vm.phoneController,
              focusNode: vm.phoneFocusNode,
              keyboardType: TextInputType.phone,
              bgColor: getMainAppTheme(context).colors.cardColor,
              isPasswordField: false,
              maxLines: null,
              readOnly: false,
              onChanged: (value) {},
              clearAvailable: true,
              title: 'Телефон',
              autoFocus: false),
          const SizedBox(
            height: 16,
          ),
          MainTextField(
              textController: vm.sallaryController,
              focusNode: vm.sallaryFocusNode,
              bgColor: getMainAppTheme(context).colors.cardColor,
              isPasswordField: false,
              maxLines: null,
              readOnly: false,
              onChanged: (value) {},
              clearAvailable: true,
              title: 'Оклад',
              autoFocus: false),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () async {
              await FlutterContactPicker.requestPermission();
              FullContact contact = await FlutterContactPicker.pickFullContact();
              vm.fullNameController.text = '${contact.name?.firstName} ${contact.name?.lastName ?? ''}';
              vm.phoneController.text = FormatterUtils.preparePhoneToMask(contact.phones.first.number ?? '');
            },
            child: Text(
              'Выбрать из контактов',
              style: getMainAppTheme(context)
                  .textStyles
                  .body
                  .copyWith(color: getMainAppTheme(context).colors.errorTextColor),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          MainAppButton(
              onPressed: () async {
                Navigator.of(context).pop(WorkerModel(
                    jobTitle: vm.currentJobTitle,
                    fullName: vm.fullNameController.text,
                    phone: vm.phoneController.text,
                    sallary: vm.sallaryController.text));
              },
              title: 'Добавить работника',
              assetIcon: ''),
        ]));
  }
}

class _ChooseJobTitleWidget extends StatelessWidget {
  const _ChooseJobTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewWorkersViewModel>(builder: (BuildContext context, vm, Widget? child) {
      return GestureDetector(
        onTap: () => showMainAppBottomSheet(context, title: 'Укажите дожность', items: vm.jobTitles).then((value) {
          if (value is int) {
            vm.setCurrentJobTitle(value);
          }
        }),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(12), color: getMainAppTheme(context).colors.cardColor),
          child: Row(children: [
            Expanded(
              child: Text(
                vm.currentJobTitle.isEmpty ? 'Должность сотрудника' : vm.currentJobTitle,
                style: getMainAppTheme(context).textStyles.body.copyWith(
                    color: vm.currentJobTitle.isEmpty
                        ? getMainAppTheme(context).colors.inactiveText
                        : getMainAppTheme(context).colors.mainTextColor),
              ),
            ),
            SvgPicture.asset(
              getMainAppTheme(context).icons.chevronRight,
              color: getMainAppTheme(context).colors.activeColor,
            )
          ]),
        ),
      );
    });
  }
}
