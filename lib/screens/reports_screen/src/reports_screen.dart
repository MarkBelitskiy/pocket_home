part of '../feature.dart';

class _ReportsScreen extends StatelessWidget {
  const _ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainAppThemeViewModel>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        body: BlocConsumer<ReportsBloc, ReportsState>(
          buildWhen: (previous, current) => current is OnInitReportsState,
          listener: (context, state) {
            if (state is ReportsGenerateError) {
              returnSnackBar(context, 'cantGenerateReport');
            }
            if (state is ShowGeneratedReportState) {
              Navigator.of(context, rootNavigator: true)
                  .push(CupertinoPageRoute(builder: (context) => PdfTitlesScreen(path: state.path)));
            }
          },
          builder: (context, state) {
            if (state is OnInitReportsState) {
              return _Reports();
            }
            return _EmptyBody();
          },
        ),
      ),
    );
  }
}

class _EmptyBody extends StatelessWidget {
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
              lottiePath: getMainAppTheme(context).icons.reportsLottie,
              margin: const EdgeInsets.only(bottom: 100),
              title: 'haveNotReports',
            ),
          ),
        ],
      ),
    );
  }
}

class _Reports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> items = [
      "servicesRatingReport",
      "budgetReport",
      "budgetIncomeReport",
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
                      style: getMainAppTheme(context)
                          .textStyles
                          .body
                          .copyWith(color: getMainAppTheme(context).colors.textOnBgColor),
                    ).tr(),
                  ),
                  Expanded(
                    child: Text(
                      items[index],
                      textAlign: TextAlign.right,
                      style: getMainAppTheme(context)
                          .textStyles
                          .body
                          .copyWith(color: getMainAppTheme(context).colors.textOnBgColor),
                    ).tr(),
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
                        context.read<ReportsBloc>().add(GenerateRatingReportEvent());
                        break;
                      case 1:
                        context.read<ReportsBloc>().add(GenerateBudgetReportEvent());
                        break;
                      case 2:
                        context.read<ReportsBloc>().add(GenerateBudgetIncomeReportEvent());
                        break;
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
