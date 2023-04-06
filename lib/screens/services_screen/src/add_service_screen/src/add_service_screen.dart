part of '../feature.dart';

class _AddServiceScreen extends StatelessWidget {
  const _AddServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        appBar: const MainAppBar(
          title: 'serviceApplicationCreate',
        ),
        body: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddServicesScreenViewModel>(context);
    return BlocListener<AddServiceBloc, AddServiceState>(
      listener: (context, state) {
        if (state is ServicesAddedState) {
          showModalBottomSheet(
              useRootNavigator: true,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
              backgroundColor: getMainAppTheme(context).colors.bgColor,
              context: context,
              builder: (context) => const _ModalBody()).then((value) {
            Navigator.of(context).pop(true);
          });
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            const _ChooseProblem(),
            const SizedBox(
              height: 12,
            ),
            const _ContactPerson(),
            const SizedBox(
              height: 12,
            ),
            const _Files(),
            const SizedBox(
              height: 12,
            ),
            const _Commentary(),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: MainAppButton(
                  onPressed: () {
                    if (vm.checkForAllIsFilled()) {
                      context.read<AddServiceBloc>().add(
                            CreateServceEvent(
                              ServiceDetailedModel(
                                commentary: vm.commentController.text,
                                name: vm.selectedProblem,
                                files: vm.files,
                                status: 0,
                                publishDate: DateTime.now(),
                                contactPerson:
                                    ContactPerson(name: vm.fullNameController.text, phone: vm.phoneController.text),
                              ),
                            ),
                          );
                    }
                  },
                  title: 'create',
                  titleColor: ColorPalette.blue200,
                ))
          ],
        ),
      ),
    );
  }
}

class _ChooseProblem extends StatefulWidget {
  const _ChooseProblem({Key? key}) : super(key: key);

  @override
  State<_ChooseProblem> createState() => _ChooseProblemState();
}

class _ChooseProblemState extends State<_ChooseProblem> {
  //TODO вынести в префы
  List<String> modalTypes = ['Протечка крыши', 'Нет света на пролете', 'Не работает домофон'];
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddServicesScreenViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'serviceName',
          style:
              getMainAppTheme(context).textStyles.title.copyWith(color: getMainAppTheme(context).colors.mainTextColor),
        ).tr(),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            showMainAppBottomSheet(
              context,
              title: 'choiceService',
              isNeedSearch: true,
              items: modalTypes,
            ).then((value) {
              if (value is int) {
                setState(() {
                  vm.selectedProblem = modalTypes[value];
                });
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: getMainAppTheme(context).colors.cardColor,
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  vm.selectedProblem.isEmpty ? 'chooseService' : vm.selectedProblem,
                  style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.grey300),
                ).tr()),
                SvgPicture.asset(
                  getMainAppTheme(context).icons.chevronDown,
                  color: getMainAppTheme(context).colors.activeColor,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _ContactPerson extends StatefulWidget {
  const _ContactPerson({Key? key}) : super(key: key);

  @override
  State<_ContactPerson> createState() => _ContactPersonState();
}

class _ContactPersonState extends State<_ContactPerson> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddServicesScreenViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'contactData',
          style:
              getMainAppTheme(context).textStyles.title.copyWith(color: getMainAppTheme(context).colors.mainTextColor),
        ).tr(),
        const SizedBox(
          height: 4,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: getMainAppTheme(context).colors.cardColor,
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'fullName',
                    style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.grey300),
                  ).tr()),
                  Expanded(
                      child: Text(
                    vm.fullNameController.text,
                    textAlign: TextAlign.right,
                    style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.grey300),
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'phone',
                    style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.grey300),
                  ).tr()),
                  Expanded(
                      child: Text(
                    vm.phoneController.text,
                    textAlign: TextAlign.right,
                    style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.grey300),
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  showChangePersonDataBottomSheet(context).then((value) => setState(() {}));
                },
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'edit',
                      style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.blue500),
                    ).tr()),
                    SvgPicture.asset(
                      getMainAppTheme(context).icons.chevronRight,
                      color: getMainAppTheme(context).colors.activeColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _Files extends StatelessWidget {
  const _Files({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddServicesScreenViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'files',
          style:
              getMainAppTheme(context).textStyles.title.copyWith(color: getMainAppTheme(context).colors.mainTextColor),
        ).tr(),
        const SizedBox(
          height: 4,
        ),
        MainAppFilePicker(
          maxFiles: 3,
          onFilesAddedCallBack: (files) {
            vm.files = files;
          },
          isProfilePhotoWidget: false,
        )
      ],
    );
  }
}

class _Commentary extends StatelessWidget {
  const _Commentary();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddServicesScreenViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'comment',
          style:
              getMainAppTheme(context).textStyles.title.copyWith(color: getMainAppTheme(context).colors.mainTextColor),
        ).tr(),
        const SizedBox(
          height: 4,
        ),
        MainTextField(
          textController: vm.commentController,
          focusNode: vm.commentFocusNode,
          isPasswordField: false,
          maxLines: 4,
          readOnly: false,
          onChanged: (value) {},
          clearAvailable: true,
        )
      ],
    );
  }
}

class _ModalBody extends StatelessWidget {
  const _ModalBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Text(
                'applicationRequestSuccess',
                textAlign: TextAlign.center,
                style: getMainAppTheme(context)
                    .textStyles
                    .body
                    .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
              ).tr(),
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                icon: SvgPicture.asset(
                  getMainAppTheme(context).icons.close,
                  color: getMainAppTheme(context).colors.mainTextColor,
                ))
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        SvgPicture.asset(getMainAppTheme(context).icons.actionSuccess),
        Padding(
          padding: const EdgeInsets.all(24),
          child: MainAppButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            title: 'close',
          ),
        )
      ],
    );
  }
}
