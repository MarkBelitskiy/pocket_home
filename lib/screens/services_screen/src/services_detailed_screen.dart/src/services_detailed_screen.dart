part of '../feature.dart';

class _ServicesDetailedScreen extends StatelessWidget {
  const _ServicesDetailedScreen({
    Key? key,
    required this.model,
    required this.numberOfService,
    required this.servicesBloc,
  }) : super(key: key);
  final ServiceDetailedModel model;
  final int numberOfService;
  final ServicesBloc servicesBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getMainAppTheme(context).colors.bgColor,
      appBar: MainAppBar(title: 'serviceRequestView', subTitle: model.name, isRoot: true),
      body: _Body(
        model: model,
        servicesBloc: servicesBloc,
        index: numberOfService,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
    required this.model,
    required this.servicesBloc,
    required this.index,
  }) : super(key: key);
  final ServiceDetailedModel model;
  final ServicesBloc servicesBloc;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        children: [
          _ContactPerson(
            model: model.contactPerson,
          ),
          const SizedBox(
            height: 12,
          ),
          if (model.choosePerson != null) ...[
            _PersonCard(
              person: model.choosePerson!,
              isBordered: true,
            ),
            const SizedBox(
              height: 12,
            ),
          ],
          if (model.files.isNotEmpty) ...[
            _Files(files: model.files),
            const SizedBox(
              height: 12,
            ),
          ],
          _Commentary(commentary: model.commentary),
          const SizedBox(
            height: 12,
          ),
          if (FormatterUtils.preparePhoneToMask(context.read<MyHousesBloc>().currentUser?.phone ?? '') ==
                  FormatterUtils.preparePhoneToMask(context.read<MyHousesBloc>().currentHouse?.manager.phone ?? '') &&
              model.status != 1 &&
              model.status != 2 &&
              model.status != 3) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      shape:
                          const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                      backgroundColor: getMainAppTheme(context).colors.bgColor,
                      context: context,
                      builder: (context) => _SetSpecialystBody(
                            itemIndex: index,
                            servicesBloc: servicesBloc,
                          )).then((value) {
                    if (value is Map) {
                      servicesBloc.add(SetWorkerEvent(value[0], value[1]));
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                  });
                },
                child: Text(
                  "setEmployee",
                  style: getMainAppTheme(context)
                      .textStyles
                      .title
                      .copyWith(color: getMainAppTheme(context).colors.activeText),
                ).tr(),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      shape:
                          const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                      backgroundColor: getMainAppTheme(context).colors.bgColor,
                      context: context,
                      builder: (context) => const _ModalBody()).then((value) {
                    if (value is String && value.isNotEmpty) {
                      servicesBloc.add(DeclineServiceEvent(index, value));
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                  });
                },
                child: Text(
                  "cancel",
                  style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.red500),
                ).tr(),
              ),
            ),
          ],
          //TODO добавть буль через event
          if (FormatterUtils.preparePhoneToMask(context.read<MyHousesBloc>().currentUser?.phone ?? '') ==
                  FormatterUtils.preparePhoneToMask(model.choosePerson?.phone ?? '') &&
              model.status != 1 &&
              model.status != 2 &&
              model.status != 3) ...[
            const SizedBox(
              height: 8,
            ),
            MainAppButton(
                onPressed: () {
                  context.read<ServicesBloc>().add(ChangeServiceValue(1, index));
                  Navigator.of(context).pop();
                },
                title: 'finishTheWork')
          ]
        ],
      ),
    );
  }
}

class _ContactPerson extends StatelessWidget {
  const _ContactPerson({Key? key, required this.model}) : super(key: key);
  final ContactPerson model;
  @override
  Widget build(BuildContext context) {
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
                      style: getMainAppTheme(context)
                          .textStyles
                          .body
                          .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                    ).tr(),
                  ),
                  Expanded(
                      child: Text(
                    model.name,
                    textAlign: TextAlign.right,
                    style: getMainAppTheme(context)
                        .textStyles
                        .body
                        .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
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
                      style: getMainAppTheme(context)
                          .textStyles
                          .body
                          .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                    ).tr(),
                  ),
                  Expanded(
                      child: Text(
                    model.phone,
                    textAlign: TextAlign.right,
                    style: getMainAppTheme(context)
                        .textStyles
                        .body
                        .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                  )),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Files extends StatelessWidget {
  const _Files({Key? key, required this.files}) : super(key: key);

  final List<String> files;
  @override
  Widget build(BuildContext context) {
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
        GridView.builder(
            shrinkWrap: true,
            itemCount: files.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 8, mainAxisExtent: 109, crossAxisSpacing: 8),
            itemBuilder: (context, index) {
              return GestureDetector(
                //TODO добавить просмотр файла
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(
                            File(files[index]),
                          )),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      border: Border.all(width: 3, color: getMainAppTheme(context).colors.buttonsColor)),
                ),
              );
            })
      ],
    );
  }
}

class _Commentary extends StatelessWidget {
  const _Commentary({required this.commentary});
  final String commentary;
  @override
  Widget build(BuildContext context) {
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
        Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: getMainAppTheme(context).colors.cardColor,
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              commentary,
              textAlign: TextAlign.left,
              style: getMainAppTheme(context)
                  .textStyles
                  .body
                  .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
            )),
      ],
    );
  }
}

class _ModalBody extends StatelessWidget {
  const _ModalBody();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
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
                  'cancelReason',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: MainTextField(
              textController: controller,
              focusNode: FocusNode(),
              title: 'comment',
              onChanged: (value) {
                controller.text = value;
              },
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: MainAppButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop(controller.text);
                },
                title: 'save',
                assetIcon: ''),
          )
        ],
      ),
    );
  }
}

class _SetSpecialystBody extends StatelessWidget {
  const _SetSpecialystBody({
    required this.servicesBloc,
    required this.itemIndex,
  });
  final int itemIndex;
  final ServicesBloc servicesBloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChoseServicePersonBloc>(
      create: (context) => ChoseServicePersonBloc(context.read<MyHousesBloc>())..add(InitPersonsDataEvent()),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
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
                    'employeeChoose',
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
            BlocBuilder<ChoseServicePersonBloc, ChoseServicePersonState>(
                buildWhen: (previous, current) => current is PersonsLoadedState,
                builder: (context, state) {
                  if (state is PersonsLoadedState) {
                    return Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 50),
                            child: MainTextField(
                              prefixIcon: getMainAppTheme(context).icons.search,
                              textController: TextEditingController(),
                              focusNode: FocusNode(),
                              title: 'search',
                              onChanged: (value) {
                                context.read<ChoseServicePersonBloc>().add(SearchPersonsEvent(value));
                              },
                              clearAvailable: true,
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: ListView.separated(
                                padding: const EdgeInsets.only(bottom: 12),
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 8,
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: state.items.length,
                                itemBuilder: (context, index) {
                                  final WorkerModel item = state.items[index];
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context, rootNavigator: true).pop({0: item, 1: itemIndex});
                                      },
                                      child: _PersonCard(person: item));
                                }),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is LoadingPersonsDataState) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                  return const SizedBox.shrink();
                })
          ],
        ),
      ),
    );
  }
}

class _PersonCard extends StatelessWidget {
  const _PersonCard({required this.person, this.isBordered = false});
  final WorkerModel person;
  final bool isBordered;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: getMainAppTheme(context).colors.cardColor,
          borderRadius: isBordered ? BorderRadius.circular(12) : null),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'fullName',
                  style: getMainAppTheme(context)
                      .textStyles
                      .body
                      .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                ).tr(),
              ),
              Expanded(
                child: Text(
                  person.fullName,
                  textAlign: TextAlign.right,
                  style: getMainAppTheme(context)
                      .textStyles
                      .body
                      .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'employeeJobTitle',
                  style: getMainAppTheme(context)
                      .textStyles
                      .body
                      .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                ).tr(),
              ),
              Expanded(
                child: Text(
                  person.jobTitle,
                  textAlign: TextAlign.right,
                  style: getMainAppTheme(context)
                      .textStyles
                      .body
                      .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                ),
              ),
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
                  style: getMainAppTheme(context)
                      .textStyles
                      .body
                      .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                ).tr(),
              ),
              Expanded(
                child: Text(
                  person.phone,
                  textAlign: TextAlign.right,
                  style: getMainAppTheme(context)
                      .textStyles
                      .body
                      .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
