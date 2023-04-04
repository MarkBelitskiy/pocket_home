part of '../feature.dart';

class _NewsScreen extends StatelessWidget {
  const _NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
        buildWhen: (previous, current) => current is NewsLoadedState || current is NewsLoadingState,
        builder: (context, state) {
          if (state is NewsLoadedState) {
            return Scaffold(
                backgroundColor: getMainAppTheme(context).colors.bgColor,
                floatingActionButton: state.currentHouse != null
                    ? MainAppFloatingButton(
                        enumValue: MainFloatingActionButton.news,
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(addNewsScreenFeature(state.currentHouse!, context.read<NewsBloc>()));
                        },
                      )
                    : const SizedBox.shrink(),
                body: _Body(
                  state: state,
                ));
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key, required this.state}) : super(key: key);
  final NewsLoadedState state;
  @override
  Widget build(BuildContext context) {
    return state.newsModel.isEmpty
        ? SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
          )
        : _NewsBody(
            news: state.newsModel,
          );
  }
}

class _NewsBody extends StatelessWidget {
  const _NewsBody({required this.news});
  final List<NewsModel> news;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.only(bottom: 150, top: 30),
        itemCount: news.length,
        separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
        itemBuilder: (context, index) {
          final news = this.news[index];
          if (news.pollAnswers?.isNotEmpty ?? false) {
            return _Poll(news: news, id: index);
          }
          return _News(
            news: news,
          );
        });
  }
}

class _News extends StatelessWidget {
  const _News({required this.news});
  final NewsModel news;
  @override
  Widget build(BuildContext context) {
    final newsText = news.newsText.length > 30 ? news.newsText.substring(0, 30) : news.newsText;
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
                'news',
                textAlign: TextAlign.left,
                style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.grey300),
              ).tr(),
            ),
            Expanded(
              child: Text(
                FormatterUtils.formattedDate(news.publishDate, context.locale.languageCode),
                textAlign: TextAlign.right,
                style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.grey300),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          news.newsTitle,
          textAlign: TextAlign.left,
          style: getMainAppTheme(context).textStyles.title.copyWith(color: ColorPalette.grey100),
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
                text: '$newsText ',
                style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.grey300),
              ),
              if (newsText.length == 30)
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(viewNewsScreenFeature(news));
                    },
                    child: Text(
                      'viewAll',
                      style: getMainAppTheme(context)
                          .textStyles
                          .body
                          .copyWith(color: getMainAppTheme(context).colors.activeText),
                    ).tr(),
                  ),
                )
            ],
          ),
        ),
        if (news.filePath.isNotEmpty) ...[
          const SizedBox(
            height: 12,
          ),
          Image.file(
            File(news.filePath),
            height: 150,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ]
      ]),
    );
  }
}

class _Poll extends StatelessWidget {
  const _Poll({required this.news, required this.id});
  final NewsModel news;
  final int id;
  @override
  Widget build(BuildContext context) {
    ValueNotifier<int?> choosenValue = ValueNotifier(null);
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
                'polls',
                textAlign: TextAlign.left,
                style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.grey300),
              ).tr(),
            ),
            Expanded(
              child: Text(
                FormatterUtils.formattedDate(news.publishDate, context.locale.languageCode),
                textAlign: TextAlign.right,
                style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.grey300),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          news.newsTitle,
          textAlign: TextAlign.left,
          style: getMainAppTheme(context).textStyles.title.copyWith(color: ColorPalette.grey100),
        ),
        const SizedBox(
          height: 12,
        ),
        ...news.pollAnswers!
            .map((e) => ValueListenableBuilder<int?>(
                  valueListenable: choosenValue,
                  builder: (context, value, child) {
                    int index = news.pollAnswers!.indexOf(e);
                    return _PollAnswer(
                      answer: e,
                      isSavedAnswer: news.choosenPollValue == index,
                      tapCallBack: (value) {
                        choosenValue.value = index;
                      },
                      isActive: news.choosenPollValue == null ? value == index : news.choosenPollValue == index,
                    );
                  },
                ))
            .toList(),
        if (news.choosenPollValue == null) ...[
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              if (choosenValue.value != null) {
                context.read<NewsBloc>().add(UpdatePollEvent(id, choosenValue.value!));
              }
            },
            child: Align(
              alignment: Alignment.center,
              child: Text('save',
                      style: getMainAppTheme(context)
                          .textStyles
                          .title
                          .copyWith(color: getMainAppTheme(context).colors.activeColor))
                  .tr(),
            ),
          ),
          const SizedBox(height: 12),
        ]
      ]),
    );
  }
}

class _PollAnswer extends StatelessWidget {
  const _PollAnswer({required this.answer, required this.tapCallBack, this.isSavedAnswer, this.isActive = false});
  final String answer;
  final Function(String) tapCallBack;
  final bool isActive;
  final bool? isSavedAnswer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tapCallBack.call(answer);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Checkbox(
              value: isActive,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              onChanged: (value) {
                tapCallBack.call(answer);
              },
              checkColor: getMainAppTheme(context).colors.activeColor,
              fillColor: MaterialStatePropertyAll(getMainAppTheme(context).colors.bgColor),
            ),
            Expanded(
                child: Text(
              answer,
              textAlign: TextAlign.left,
              style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.grey300),
            )),
            if (isSavedAnswer != null && isSavedAnswer!) ...[
              Text(
                'yourAnswer',
                textAlign: TextAlign.left,
                style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.blue500),
              ).tr(),
              const SizedBox(
                width: 12,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
