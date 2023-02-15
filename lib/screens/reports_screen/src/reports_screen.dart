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
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => PdfTitlesScreen(
                        pdfData: state.pdfData,
                        pdfPath: '',
                      )));
            }
            if (state is OnRatingGettedState) {
              showModalBottomSheet(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                  backgroundColor: getMainAppTheme(context).colors.bgColor,
                  context: context,
                  builder: (context) => _ModalBody(list: state.list));
            }
          },
          builder: (context, state) {
            return const _Reports();
          },
        ));
  }
}

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
  const _Reports({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> items = ['Жильцы', 'Рейтинг оказанных услуг', 'Бюджет на год'];
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
                      'Отчет',
                      textAlign: TextAlign.left,
                      style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.grey300),
                    ),
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
                    index == 1
                        ? context.read<ReportsBloc>().add(GenerateReportEvent())
                        : context.read<ReportsBloc>().add(OnPdfViewEvent());
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Формировать',
                            style: getMainAppTheme(context)
                                .textStyles
                                .title
                                .copyWith(color: getMainAppTheme(context).colors.activeColor)),
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
    super.key,
    required this.list,
  });
  final List<RatingReportModel> list;
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
                ))
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
                        DateFormat.MMMEd().format(list[index].date),
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
                            '${list[index].worker.name} ${list[index].worker.jobTitle}',
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
