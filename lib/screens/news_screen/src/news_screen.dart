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
          if (state.newsModel.isEmpty) {
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
              news: state.newsModel,
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
    return ListView.separated(
        itemCount: news.length,
        separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
        itemBuilder: (context, index) {
          final _news = news[index];
          if (_news.pollAnswers?.isNotEmpty ?? false) {
            return _Poll(news: _news, id: index);
          }
          return _News(
            news: _news,
          );
        });
  }
}

class _News extends StatelessWidget {
  const _News({required this.news});
  final NewsModel news;
  @override
  Widget build(BuildContext context) {
    final _newsText = news.newsText.length > 50
        ? news.newsText.substring(0, 50)
        : news.newsText;
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
                locale.DateFormat('d MMMM yyyy', context.locale.languageCode)
                    .format(news.publishDate)
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
          news.newsTitle,
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
                text: _newsText + ' ',
                style: getMainAppTheme(context)
                    .textStyles
                    .body
                    .copyWith(color: ColorPalette.grey300),
              ),
              if (_newsText.length == 50)
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(viewNewsScreenFeature(news));
                    },
                    child: Text(
                      'Просмотреть полностью...',
                      style: getMainAppTheme(context).textStyles.body.copyWith(
                          color: getMainAppTheme(context).colors.activeText),
                    ),
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
  const _Poll({super.key, required this.news, required this.id});
  final NewsModel news;
  final int id;
  @override
  Widget build(BuildContext context) {
    ValueNotifier<int?> _choosenValue = ValueNotifier(null);
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
                'Опросы',
                textAlign: TextAlign.left,
                style: getMainAppTheme(context)
                    .textStyles
                    .body
                    .copyWith(color: ColorPalette.grey300),
              ),
            ),
            Expanded(
              child: Text(
                locale.DateFormat('d MMMM yyyy', context.locale.languageCode)
                    .format(news.publishDate)
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
          news.newsTitle,
          textAlign: TextAlign.left,
          style: getMainAppTheme(context)
              .textStyles
              .title
              .copyWith(color: ColorPalette.grey100),
        ),
        const SizedBox(
          height: 12,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (count, index) {
            return ValueListenableBuilder<int?>(
              valueListenable: _choosenValue,
              builder: (context, value, child) {
                return _PollAnswer(
                  answer: news.pollAnswers![index],
                  isSavedAnswer: news.choosenPollValue == index,
                  tapCallBack: (value) {
                    _choosenValue.value = index;
                  },
                  isActive: news.choosenPollValue == null
                      ? value == index
                      : news.choosenPollValue == index,
                );
              },
            );
          },
          itemCount: news.pollAnswers?.length,
        ),
        if (news.choosenPollValue == null) ...[
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              if (_choosenValue.value != null) {
                context
                    .read<NewsBloc>()
                    .add(UpdatePollEvent(id, _choosenValue.value!));
              }
            },
            child: Align(
              alignment: Alignment.center,
              child: Text('Сохранить',
                  style: getMainAppTheme(context).textStyles.title.copyWith(
                      color: getMainAppTheme(context).colors.activeColor)),
            ),
          ),
          const SizedBox(height: 12),
        ]
      ]),
    );
  }
}

class _PollAnswer extends StatelessWidget {
  const _PollAnswer(
      {super.key,
      required this.answer,
      required this.tapCallBack,
      this.isSavedAnswer,
      this.isActive = false});
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
            if (isSavedAnswer == null) ...[
              Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  value: isActive,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  onChanged: (value) {
                    tapCallBack.call(answer);
                  },
                  checkColor: getMainAppTheme(context).colors.activeColor,
                  fillColor: MaterialStatePropertyAll(
                      getMainAppTheme(context).colors.bgColor),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
            ],
            Expanded(
                child: Text(
              answer,
              textAlign: TextAlign.left,
              style: getMainAppTheme(context)
                  .textStyles
                  .body
                  .copyWith(color: ColorPalette.grey300),
            )),
            if (isSavedAnswer != null && isSavedAnswer!) ...[
              Transform.scale(
                  scale: 1.3,
                  child: Text(
                    'Ваш ответ',
                    textAlign: TextAlign.left,
                    style: getMainAppTheme(context)
                        .textStyles
                        .caption
                        .copyWith(color: ColorPalette.blue500),
                  )),
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
