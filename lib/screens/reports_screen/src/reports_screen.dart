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
    List<String> items = ['Жильцы', 'Оказанные услуги', 'Бюджет на год'];
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Отчет',
                      textAlign: TextAlign.left,
                      style: getMainAppTheme(context)
                          .textStyles
                          .body
                          .copyWith(color: ColorPalette.grey300),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      items[index],
                      textAlign: TextAlign.right,
                      style: getMainAppTheme(context)
                          .textStyles
                          .body
                          .copyWith(color: ColorPalette.grey300),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                  onTap: () {
                    context.read<ReportsBloc>().add(OnPdfViewEvent());
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('Формировать',
                            style: getMainAppTheme(context)
                                .textStyles
                                .title
                                .copyWith(
                                    color: getMainAppTheme(context)
                                        .colors
                                        .activeColor)),
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
