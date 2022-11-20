part of '../feature.dart';

class _NewsScreen extends StatelessWidget {
  const _NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        floatingActionButton: MainAppFloatingButton(onTap: () {
          Navigator.of(context).push(addNewsScreenFeature());
        }),
        body: const _Body());
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
            child: EmptyPlaceholderWithLottie(
              lottiePath: getMainAppTheme(context).icons.lottieNews,
              margin: const EdgeInsets.only(bottom: 110, left: 20),
              title: 'haveNotNews',
            ),
          ),
        ],
      ),
    );
  }
}
