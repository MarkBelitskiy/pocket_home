part of '../feature.dart';

class _NewsScreen extends StatelessWidget {
  const _NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        floatingActionButton: MainAppFloatingButton(onTap: () {
          Navigator.of(context, rootNavigator: true)
              .push(addNewsScreenFeature())
              .then((value) {
            if (value is bool && value) {
              context.read<NewsBloc>().add(OnNewsTabInit());
            }
          });
        }),
        body: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsBloc, NewsState>(
      listener: (context, state) {},
      buildWhen: (previous, current) =>
          current is NewsLoadedState || current is NewsLoadingState,
      builder: (context, state) {
        if (state is NewsLoadedState) {
          if (state.newsModel == null) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: EmptyPlaceholderWithLottie(
                      lottiePath: getMainAppTheme(context).icons.lottieNews,
                      margin: const EdgeInsets.only(bottom: 110, left: 20),
                      title: 'haveNotNews',
                    ),
                  ),
                ],
              ),
            );
          } else {
            return _NewsBody(
              news: [state.newsModel!],
            );
          }
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _NewsBody extends StatelessWidget {
  const _NewsBody({super.key, required this.news});
  final List<NewsModel> news;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          final _news = news[index];
          final _newsText = _news.newsText.length > 60
              ? _news.newsText.substring(0, 60)
              : _news.newsText;
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
                      'Новости',
                      textAlign: TextAlign.left,
                      style: getMainAppTheme(context)
                          .textStyles
                          .body
                          .copyWith(color: ColorPalette.grey300),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      locale.DateFormat(
                              'd MMMM yyyy', context.locale.languageCode)
                          .format(_news.publishDate)
                          .toString()
                          .toLowerCase(),
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
              Text(
                _news.newsTitle,
                textAlign: TextAlign.left,
                style: getMainAppTheme(context)
                    .textStyles
                    .title
                    .copyWith(color: ColorPalette.grey100),
              ),
              const SizedBox(
                height: 12,
              ),
              RichText(
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.clip,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: _newsText,
                      style: getMainAppTheme(context)
                          .textStyles
                          .body
                          .copyWith(color: ColorPalette.grey300),
                    ),
                    if (_newsText.length == 60)
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            ' Читать далее...',
                            style: getMainAppTheme(context)
                                .textStyles
                                .body
                                .copyWith(
                                    color: getMainAppTheme(context)
                                        .colors
                                        .activeText),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              if (_news.filePath.isNotEmpty) ...[
                const SizedBox(
                  height: 12,
                ),
                Image.file(
                  File(_news.filePath),
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ]
            ]),
          );
        });
  }
}
