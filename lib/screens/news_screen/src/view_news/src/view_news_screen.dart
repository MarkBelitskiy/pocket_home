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
        title: 'newsView',
      ),
      body: MainAppBody(
        needPadding: false,
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
