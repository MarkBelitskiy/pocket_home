part of '../feature.dart';

class _AddNewsScreen extends StatelessWidget {
  const _AddNewsScreen({Key? key}) : super(key: key);

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
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(
                getMainAppTheme(context).icons.emptyDoubleBlob,
                width: MediaQuery.of(context).size.width,
              )),
          Positioned(
            bottom: 0,
            top: 50,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [],
                )),
          ),
        ],
      ),
    );
  }
}
