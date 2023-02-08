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
            Navigator.of(context, rootNavigator: true).push(addServicesScreenFeature());
          },
        ),
        appBar: const MainAppBar(
          title: '',
          leadingEnable: false,
          tabNames: ['Активные', 'История'],
        ),
        body: BlocConsumer<ServicesBloc, ServicesState>(
          listener: (context, state) {},
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
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 90, bottom: 20),
      child: Column(
        children: models.map((e) => _CardItem(item: e)).toList(),
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({super.key, required this.item});
  final ServiceDetailedModel item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onLongPress: () {},
      child: Container(
        color: getMainAppTheme(context).colors.cardColor,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(children: [
          Row(
            children: [
              Text(
                'Заявка № 1',
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
                    textAlign: TextAlign.left,
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
        returned = ColorPalette.green500;
        break;
      case 2:
        returned = ColorPalette.red500;
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
        returned = 'Выполнена';
        break;
      case 2:
        returned = 'Отклонена';
        break;

      default:
        returned = 'В работе';
    }
    return returned;
  }
}
