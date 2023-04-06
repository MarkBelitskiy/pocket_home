part of '../feature.dart';

class _ServicesScreen extends StatelessWidget {
  const _ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        floatingActionButton: MainAppFloatingButton(
          enumValue: MainFloatingActionButton.services,
          onTap: (currentHouse) {
            Navigator.of(context, rootNavigator: true)
                .push(addServicesScreenFeature(context.read<ServicesBloc>(), currentHouse!));
          },
        ),
        appBar: const MainAppBar(
          leadingEnable: false,
          tabNames: ['active', 'history'],
        ),
        body: BlocBuilder<ServicesBloc, ServicesState>(
          buildWhen: (previous, current) => current is ServicesLoaded,
          builder: (context, state) {
            if (state is ServicesLoaded) {
              if (state.activeModels.isEmpty && state.historyModels.isEmpty) {
                return const _EpmtyBody(
                  title: 'haveNotServicesRequests',
                );
              }
              return TabBarView(
                children: [
                  _TabBody(
                    models: state.activeModels,
                    title: "haveNotActiveServices",
                    currentHouse: state.currentHouse,
                  ),
                  _TabBody(
                    models: state.historyModels,
                    title: 'uHaveNotHistoryOfServicesRequests',
                    currentHouse: state.currentHouse,
                  ),
                ],
              );
            }
            return const _EpmtyBody(
              title: 'haveNotServicesRequests',
            );
          },
        ),
      ),
    );
  }
}

class _EpmtyBody extends StatelessWidget {
  const _EpmtyBody({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: EmptyPlaceholderWithLottie(
              lottiePath: 'assets/lottie/services.json',
              margin: const EdgeInsets.only(bottom: 70, left: 10),
              title: title,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBody extends StatelessWidget {
  const _TabBody({
    Key? key,
    required this.models,
    required this.title,
    required this.currentHouse,
  }) : super(key: key);
  final List<ServiceDetailedModel> models;
  final String title;
  final HouseModel currentHouse;
  @override
  Widget build(BuildContext context) {
    if (models.isEmpty) {
      return _EpmtyBody(
        title: title,
      );
    }
    return ListView.builder(
        padding: const EdgeInsets.only(top: 90, bottom: 70),
        itemCount: models.length,
        itemBuilder: (context, index) {
          return _CardItem(
            item: models[index],
            index: index,
            currentHouse: currentHouse,
          );
        });
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({
    required this.item,
    required this.index,
    required this.currentHouse,
  });
  final ServiceDetailedModel item;
  final int index;
  final HouseModel currentHouse;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.status == 1 &&
            FormatterUtils.preparePhoneToMask(context.read<MyHousesBloc>().currentUser!.phone) ==
                FormatterUtils.preparePhoneToMask(item.contactPerson.phone)) {
          showModalBottomSheet(
              isScrollControlled: true,
              useRootNavigator: true,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
              backgroundColor: getMainAppTheme(context).colors.bgColor,
              context: context,
              builder: (modelConttext) => _ModalBody(
                    item: index,
                    servicesBloc: context.read<ServicesBloc>(),
                  ));
        } else {
          Navigator.of(context, rootNavigator: true)
              .push(
                servicesDetailedScreenFeature(item, index, context.read<ServicesBloc>(), currentHouse),
              )
              .then((value) => context.read<ServicesBloc>().add(ScreenUpdateEvent()));
        }
      },
      onLongPress: () {
        if (item.choosePerson != null) {
          showModalBottomSheet(
              useRootNavigator: true,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
              backgroundColor: getMainAppTheme(context).colors.bgColor,
              context: context,
              builder: (modelConttext) => _ModalBody(
                    item: index,
                    servicesBloc: context.read<ServicesBloc>(),
                  ));
        }
      },
      child: Container(
        color: getMainAppTheme(context).colors.cardColor,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(children: [
          Row(
            children: [
              Text(
                'serviceNumber',
                textAlign: TextAlign.left,
                style: getMainAppTheme(context).textStyles.body.copyWith(color: getItemColor(0)),
              ).tr(args: [(index + 1).toString()]),
              Expanded(
                child: Text(
                  FormatterUtils.formattedDate(item.publishDate, context.locale.languageCode),
                  textAlign: TextAlign.right,
                  style: getMainAppTheme(context).textStyles.body.copyWith(color: getItemColor(0)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              Text(
                'serviceName',
                textAlign: TextAlign.left,
                style: getMainAppTheme(context).textStyles.body.copyWith(color: getItemColor(0)),
              ).tr(),
              Expanded(
                child: Text(
                  item.name,
                  textAlign: TextAlign.right,
                  style: getMainAppTheme(context).textStyles.body.copyWith(color: getItemColor(0)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              Text(
                'status',
                textAlign: TextAlign.left,
                style: getMainAppTheme(context).textStyles.body.copyWith(color: getItemColor(0)),
              ).tr(),
              Expanded(
                child: Text(
                  getStatusText(item.status),
                  textAlign: TextAlign.right,
                  style: getMainAppTheme(context).textStyles.body.copyWith(color: getItemColor(item.status)),
                ).tr(),
              ),
            ],
          ),
          if (item.workerCommentary != null) ...[
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                const SizedBox(
                  height: 14,
                ),
                Text(
                  'comment',
                  textAlign: TextAlign.left,
                  style: getMainAppTheme(context).textStyles.body.copyWith(color: getItemColor(0)),
                ).tr(),
                Expanded(
                  child: Text(
                    item.workerCommentary!,
                    textAlign: TextAlign.right,
                    style: getMainAppTheme(context).textStyles.body.copyWith(color: getItemColor(item.status)),
                  ),
                ),
              ],
            ),
          ]
        ]),
      ),
    );
  }

  Color getItemColor(int status) {
    Color returned = ColorPalette.grey300;
    switch (status) {
      case 1:
        returned = ColorPalette.yellow500;
        break;
      case 2:
        returned = ColorPalette.red500;
        break;
      case 3:
        returned = ColorPalette.green500;
        break;

      default:
        returned = ColorPalette.grey300;
    }
    return returned;
  }

  String getStatusText(int status) {
    //TODO LOCALE
    String returned = 'inWork';
    switch (status) {
      case 1:
        returned = 'completeNeedSetRatingStatus';
        break;
      case 2:
        returned = 'declineStatus';
        break;
      case 3:
        returned = 'completeStatus';
        break;

      default:
        returned = 'inWork';
    }
    return returned;
  }
}

class _ModalBody extends StatefulWidget {
  const _ModalBody({
    required this.item,
    required this.servicesBloc,
  });
  final int item;
  final ServicesBloc servicesBloc;

  @override
  State<_ModalBody> createState() => _ModalBodyState();
}

class _ModalBodyState extends State<_ModalBody> {
  TextEditingController controller = TextEditingController();
  FocusNode focus = FocusNode();
  int value = 0;
  @override
  Widget build(BuildContext context) {
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
                  'workRating',
                  textAlign: TextAlign.center,
                  style: getMainAppTheme(context)
                      .textStyles
                      .body
                      .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                ).tr(),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
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
          _RateWidget(
            callback: (returnedValue) {
              value = returnedValue;
            },
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: MainTextField(
              textController: controller,
              focusNode: focus,
              title: 'comment',
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: MainAppButton(
              onPressed: () {
                if (value != 0) {
                  Navigator.of(context, rootNavigator: true).pop();
                  widget.servicesBloc.add(SetRatingValueEvent(value, widget.item));
                }
              },
              title: 'save',
            ),
          )
        ],
      ),
    );
  }
}

class _RateWidget extends StatefulWidget {
  const _RateWidget({required this.callback});
  final Function(int value) callback;
  @override
  State<_RateWidget> createState() => _RateWidgetState();
}

class _RateWidgetState extends State<_RateWidget> {
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            setState(() {
              value = index + 1;
              widget.callback(value);
            });
          },
          color: index < value ? ColorPalette.yellow500 : ColorPalette.grey400,
          iconSize: 36.0,
          icon: Icon(
            index < value ? Icons.star : Icons.star_border,
          ),
          padding: EdgeInsets.zero,
        );
      }),
    );
  }
}
