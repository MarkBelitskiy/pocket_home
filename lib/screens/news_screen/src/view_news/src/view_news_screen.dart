part of '../feature.dart';

class _ViewNewsScreen extends StatelessWidget {
  const _ViewNewsScreen({Key? key, required this.news}) : super(key: key);
  final NewsModel news;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        appBar: const MainAppBar(
          title: 'Просмотр новости',
        ),
        body: _Body(
          news: news,
        ));
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key, required this.news}) : super(key: key);
  final NewsModel news;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: MainAppBody(
        needPadding: false,
        isDoubleBlob: false,
        children: [
          _NewsBody(
            news: news,
          ),
        ],
      ),
    );
  }
}

class _NewsBody extends StatelessWidget {
  const _NewsBody({super.key, required this.news});
  final NewsModel news;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: getMainAppTheme(context).colors.cardColor,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                news.newsTitle,
                textAlign: TextAlign.left,
                style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.grey300),
              ),
              Expanded(
                child: Text(
                  DateFormat('d MMMM yyyy', context.locale.languageCode)
                      .format(news.publishDate)
                      .toString()
                      .toLowerCase(),
                  textAlign: TextAlign.right,
                  style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.grey300),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          if (news.filePath.isNotEmpty) ...[
            Image.file(
              File(news.filePath),
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 12,
            )
          ],
          Text(
            news.newsText,
            style: getMainAppTheme(context).textStyles.body.copyWith(color: ColorPalette.grey300),
          ),
        ],
      ),
    );
  }
}
