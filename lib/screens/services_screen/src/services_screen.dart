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
                  _TabBody(models: state.activeModels),
                  _TabBody(models: state.historyModels),
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
  const _TabBody({Key? key, required this.models}) : super(key: key);
  final List<ServiceItemModel> models;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90),
      child: MainAppBody(
        isDoubleBlob: true,
        children: models.map((e) => _CardItem(item: e)).toList(),
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({super.key, required this.item});
  final ServiceItemModel item;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: getMainAppTheme(context).colors.cardColor,
      padding: const EdgeInsets.all(12),
      child: Column(children: [
        Row(
          children: [
            Text(
              'Заявка №item.serviceNumber',
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
                item.serviceName,
                textAlign: TextAlign.left,
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
                textAlign: TextAlign.left,
                style: getMainAppTheme(context).textStyles.body.copyWith(color: getItemColor(item.status)),
              ),
            ),
          ],
        ),
        if (item.comment != null) ...[
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
                  item.comment!,
                  textAlign: TextAlign.left,
                  style: getMainAppTheme(context).textStyles.body.copyWith(color: getItemColor(item.status)),
                ),
              ),
            ],
          ),
        ]
      ]),
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
