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
        resizeToAvoidBottomInset: false,
        floatingActionButton: MainAppFloatingButton(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(addServicesScreenFeature(context.read<ServicesBloc>()));
          },
        ),
        appBar: const MainAppBar(
          title: '',
          leadingEnable: false,
          tabNames: ['Активные', 'История'],
        ),
        body: BlocConsumer<ServicesBloc, ServicesState>(
          listener: (context, state) {
            if (state is RatingSetToServiceState) {
              Navigator.of(
                context,
              ).pop();
            }
          },
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
                    title: 'У вас пока нет активных заявок',
                  ),
                  _TabBody(
                    models: state.historyModels,
                    title: 'У вас пока нет истории заявок',
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
  const _TabBody({Key? key, required this.models, required this.title}) : super(key: key);
  final List<ServiceDetailedModel> models;
  final String title;
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
          );
        });
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({super.key, required this.item, required this.index});
  final ServiceDetailedModel item;
  final int index;
  @override
  Widget build(BuildContext context) {
    List<String> itemValues = [
      'В работе',
      'Выполнена',
      'Отклонена',
    ];
    return GestureDetector(
      onTap: () {
        if (item.status == 1) {
          showModalBottomSheet(
              isScrollControlled: true,
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
                servicesDetailedScreenFeature(
                  item,
                  index,
                  context.read<ServicesBloc>(),
                ),
              )
              .then((value) => context.read<ServicesBloc>().add(ScreenUpdateEvent()));
        }
      },
      onLongPress: () {
        showMainAppBottomSheet(
          context,
          title: 'Изменение статуса(Тест сборка)',
          items: itemValues,
        ).then(
          (value) => context.read<ServicesBloc>().add(
                ChangeServiceValue(value, index),
              ),
        );
      },
      child: Container(
        color: getMainAppTheme(context).colors.cardColor,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(children: [
          Row(
            children: [
              Text(
                'Заявка № ${index + 1}',
                textAlign: TextAlign.left,
                style: getMainAppTheme(context).textStyles.body.copyWith(color: getItemColor(0)),
              ),
              Expanded(
                child: Text(
                  DateFormat('d MMMM yyyy', context.locale.languageCode)
                      .format(item.publishDate)
                      .toString()
                      .toLowerCase(),
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
                'Наименование',
                textAlign: TextAlign.left,
                style: getMainAppTheme(context).textStyles.body.copyWith(color: getItemColor(0)),
              ),
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
                'Статус',
                textAlign: TextAlign.left,
                style: getMainAppTheme(context).textStyles.body.copyWith(color: getItemColor(0)),
              ),
              Expanded(
                child: Text(
                  getStatusText(item.status),
                  textAlign: TextAlign.right,
                  style: getMainAppTheme(context).textStyles.body.copyWith(color: getItemColor(item.status)),
                ),
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
                  'Комментарий',
                  textAlign: TextAlign.left,
                  style: getMainAppTheme(context).textStyles.body.copyWith(color: getItemColor(0)),
                ),
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
    String returned = 'В работе';
    switch (status) {
      case 1:
        returned = 'Выполнена ожидает оценки';
        break;
      case 2:
        returned = 'Отклонена';
        break;
      case 3:
        returned = 'Завершена';
        break;

      default:
        returned = 'В работе';
    }
    return returned;
  }
}

class _ModalBody extends StatelessWidget {
  const _ModalBody({
    super.key,
    required this.item,
    required this.servicesBloc,
  });
  final int item;
  final ServicesBloc servicesBloc;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    int value = 0;
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
                  'Оценка работы',
                  textAlign: TextAlign.center,
                  style: getMainAppTheme(context)
                      .textStyles
                      .body
                      .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                ),
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
                focusNode: FocusNode(),
                bgColor: getMainAppTheme(context).colors.buttonsColor,
                isPasswordField: false,
                maxLines: 1,
                title: 'Комментарий',
                readOnly: false,
                onChanged: (value) {
                  controller.text = value;
                },
                clearAvailable: true,
                autoFocus: false),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: MainAppButton(
                onPressed: () {
                  if (value != 0) {
                    servicesBloc.add(SetRatingValueEvent(value, item));
                  }
                },
                title: 'Сохранить',
                assetIcon: ''),
          )
        ],
      ),
    );
  }
}

class _RateWidget extends StatefulWidget {
  const _RateWidget({super.key, required this.callback});
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
          tooltip: "${index + 1} of 5",
        );
      }),
    );
  }
}
