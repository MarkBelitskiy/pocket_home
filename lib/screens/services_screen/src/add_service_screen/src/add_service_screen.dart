part of '../feature.dart';

class _AddServiceScreen extends StatelessWidget {
  const _AddServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        appBar: const MainAppBar(
          title: 'Создание заявки',
        ),
        body: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddServicesScreenViewModel>(context);
    return SingleChildScrollView(
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
                  context.read<AddServiceBloc>().add(CreateServceEvent(ServiceDetailedModel(
                      commentary: vm.commentController.text,
                      name: vm.selectedProblem,
                      files: vm.files,
                      status: 1,
                      publishDate: DateTime.now(),
                      contactPerson: ContactPerson(name: vm.fullNameController.text, phone: vm.phoneController.text))));
                },
                title: 'Создать',
                assetIcon: '',
                titleColor: ColorPalette.blue200,
              ))
        ],
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
  List<String> modalTypes = ['Протечка крыши', 'Нет света на пролете', 'Не работает домофон'];
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddServicesScreenViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Наименование',
          style:
              getMainAppTheme(context).textStyles.title.copyWith(color: getMainAppTheme(context).colors.mainTextColor),
        ),
        const SizedBox(
          height: 4,
        ),
        GestureDetector(
          onTap: () {
            showMainAppBottomSheet(
              context,
              title: 'Выбор услуги',
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
                  vm.selectedProblem.isEmpty ? 'Выберите услугу' : vm.selectedProblem,
                  style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.grey300),
                )),
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
          'Контактные данные',
          style:
              getMainAppTheme(context).textStyles.title.copyWith(color: getMainAppTheme(context).colors.mainTextColor),
        ),
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
                    'ФИО',
                    style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.grey300),
                  )),
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
                    'Телефон',
                    style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.grey300),
                  )),
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
                      'Редактировать',
                      style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.blue500),
                    )),
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
          'Файлы',
          style:
              getMainAppTheme(context).textStyles.title.copyWith(color: getMainAppTheme(context).colors.mainTextColor),
        ),
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
  const _Commentary({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddServicesScreenViewModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Комментарий',
          style:
              getMainAppTheme(context).textStyles.title.copyWith(color: getMainAppTheme(context).colors.mainTextColor),
        ),
        const SizedBox(
          height: 4,
        ),
        MainTextField(
            textController: vm.commentController,
            focusNode: vm.commentFocusNode,
            bgColor: getMainAppTheme(context).colors.cardColor,
            isPasswordField: false,
            maxLines: 4,
            readOnly: false,
            onChanged: (value) {},
            clearAvailable: true,
            autoFocus: false)
      ],
    );
  }
}
