part of '../feature.dart';

class _ChatScreen extends StatelessWidget {
  const _ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: getMainAppTheme(context).colors.bgColor,
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
            child: const EmptyPlaceholderWithLottie(
              lottiePath: 'assets/lottie/chat.json',
              margin: EdgeInsets.only(bottom: 110, left: 20),
              title: 'haveNotChats',
            ),
          ),
        ],
      ),
    );
  }
}
