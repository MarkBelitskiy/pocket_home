part of '../feature.dart';

class _ReportsScreen extends StatelessWidget {
  const _ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        body: BlocConsumer<ReportsBloc, ReportsState>(
          listener: (context, state) {
            if (state is OpenPdfState) {
              // Navigator.of(context).push(CupertinoPageRoute(
              // builder: (context) => PdfTitlesScreen(
              // pdfData: state.pdfData,
              // pdfPath: '',
              // )));
            }
            if (state is OnRatingGettedState) {
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                  backgroundColor: getMainAppTheme(context).colors.bgColor,
                  context: context,
                  builder: (context) => _ModalBody(list: state.list));
            }
            if (state is OnBudgetGeneratedState) {
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                  backgroundColor: getMainAppTheme(context).colors.bgColor,
                  context: context,
                  builder: (context) => _BudgetModalBody(model: state.model));
            }
          },
          builder: (context, state) {
            return const _Reports();
          },
        ));
  }
}

//TODO Удалить
class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const EmptyPlaceholderWithLottie(
              lottiePath: 'assets/lottie/reports.json',
              margin: EdgeInsets.only(bottom: 100),
              title: 'haveNotReports',
            ),
          ),
        ],
      ),
    );
  }
}

class _Reports extends StatelessWidget {
  const _Reports();

  @override
  Widget build(BuildContext context) {
    //TODO вынести в префы + локаль
    List<String> items = [
      'Рейтинг оказанных услуг',
      'Отчет по бюджету за Месяц',
      'ПДФ-Отчёт',
    ];
    return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: getMainAppTheme(context).colors.cardColor,
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'report',
                      textAlign: TextAlign.left,
                      style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.grey300),
                    ).tr(),
                  ),
                  Expanded(
                    child: Text(
                      items[index],
                      textAlign: TextAlign.right,
                      style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.grey300),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                  onTap: () {
                    switch (index) {
                      case 0:
                        context.read<ReportsBloc>().add(GenerateReportEvent());
                        break;
                      case 1:
                        context.read<ReportsBloc>().add(GenerateBudgetReportEvent());
                        break;
                      default:
                        context.read<ReportsBloc>().add(OnPdfViewEvent());
                    }
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('generate',
                                style: getMainAppTheme(context)
                                    .textStyles
                                    .title
                                    .copyWith(color: getMainAppTheme(context).colors.activeColor))
                            .tr(),
                      ),
                      SvgPicture.asset(
                        getMainAppTheme(context).icons.chevronRight,
                        color: getMainAppTheme(context).colors.activeColor,
                      )
                    ],
                  )),
            ]),
          );
        });
  }
}

class _ModalBody extends StatelessWidget {
  const _ModalBody({
    required this.list,
  });
  final List<RatingReportModel> list;
  @override
  Widget build(BuildContext context) {
    //TODO заменить на генерацию PDF widget
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
                'Рейтинг оказанных услуг',
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
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              height: 25,
              thickness: 1,
              color: getMainAppTheme(context).colors.cardColor,
            ),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(12),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Дата',
                        style: getMainAppTheme(context)
                            .textStyles
                            .body
                            .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                      )),
                      Expanded(
                          child: Text(
                        FormatterUtils.formattedDate(list[index].date, context.locale.languageCode),
                        textAlign: TextAlign.right,
                        style: getMainAppTheme(context)
                            .textStyles
                            .body
                            .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Рабочий',
                        style: getMainAppTheme(context)
                            .textStyles
                            .body
                            .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                      )),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${list[index].worker.fullName} ${list[index].worker.jobTitle}',
                            textAlign: TextAlign.right,
                            style: getMainAppTheme(context)
                                .textStyles
                                .body
                                .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            list[index].worker.phone,
                            textAlign: TextAlign.right,
                            style: getMainAppTheme(context)
                                .textStyles
                                .body
                                .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                          )
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Поставленный рейтинг',
                        style: getMainAppTheme(context)
                            .textStyles
                            .body
                            .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                      )),
                      Expanded(
                          child: Text(
                        list[index].rating.toString(),
                        textAlign: TextAlign.right,
                        style: getMainAppTheme(context)
                            .textStyles
                            .body
                            .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                      )),
                    ],
                  ),
                ]),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: MainAppButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              title: 'Закрыть',
              assetIcon: ''),
        )
      ],
    );
  }
}

class _BudgetModalBody extends StatelessWidget {
  const _BudgetModalBody({
    required this.model,
  });
  final BudgetReportModel model;
  @override
  Widget build(BuildContext context) {
    //TODO заменить на генерацию PDF widget
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Row(
            children: [
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: Text(
                  'Отчёт по бюджету дома за месяц',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  'Бюджет на начало месяца',
                  style: getMainAppTheme(context)
                      .textStyles
                      .body
                      .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                )),
                Expanded(
                    child: Text(
                  '${model.total} ₸',
                  textAlign: TextAlign.right,
                  style: getMainAppTheme(context)
                      .textStyles
                      .body
                      .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                )),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Выплата рабочим',
              style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.yellow500),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => Divider(
              height: 25,
              thickness: 1,
              color: getMainAppTheme(context).colors.cardColor,
            ),
            shrinkWrap: true,
            itemCount: model.worker.length,
            itemBuilder: (context, index) {
              WorkerModel worker = model.worker[index];
              return Container(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Имя рабочего',
                        style: getMainAppTheme(context)
                            .textStyles
                            .body
                            .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                      )),
                      Expanded(
                          child: Text(
                        worker.fullName,
                        textAlign: TextAlign.right,
                        style: getMainAppTheme(context)
                            .textStyles
                            .body
                            .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Оклад',
                        style: getMainAppTheme(context)
                            .textStyles
                            .body
                            .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                      )),
                      Expanded(
                          child: Text(
                        '${worker.sallary} ₸',
                        textAlign: TextAlign.right,
                        style: getMainAppTheme(context)
                            .textStyles
                            .body
                            .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ]),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  'Остаток на конец месяца',
                  style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.green500),
                )),
                Expanded(
                    child: Text(
                  '${model.totalFromMonth} ₸',
                  textAlign: TextAlign.right,
                  style: getMainAppTheme(context)
                      .textStyles
                      .body
                      .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: MainAppButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                title: 'Закрыть',
                assetIcon: ''),
          )
        ],
      ),
    );
  }
}
