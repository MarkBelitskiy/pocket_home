part of '../feature.dart';

class _RegisterScreen extends StatelessWidget {
  const _RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getMainAppTheme(context).colors.bgColor,
      appBar: const MainAppBar(
        title: 'Регистрация',
      ),
      body: const MainAppBody(isDoubleBlob: false, children: [_Body()]),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 75,
              backgroundColor: getMainAppTheme(context).colors.cardColor,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  'assets/images/app_launch_image.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                getMainAppTheme(context).icons.camera,
                width: 32,
                height: 32,
                color: getMainAppTheme(context).colors.mainTextColor,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 32,
        ),
        MainTextField(
            textController: TextEditingController(),
            focusNode: FocusNode(),
            bgColor: getMainAppTheme(context).colors.cardColor,
            isPasswordField: false,
            maxLines: 1,
            readOnly: false,
            onChanged: (value) {},
            clearAvailable: true,
            title: 'Логин',
            autoFocus: false),
        const SizedBox(
          height: 32,
        ),
        MainTextField(
            textController: TextEditingController(),
            focusNode: FocusNode(),
            bgColor: getMainAppTheme(context).colors.cardColor,
            isPasswordField: false,
            maxLines: 1,
            keyboardType: TextInputType.phone,
            readOnly: false,
            onChanged: (value) {},
            clearAvailable: true,
            title: 'Телефон',
            autoFocus: false),
        const SizedBox(
          height: 32,
        ),
        MainAppButton(
            onPressed: () {},
            titleColor: ColorPalette.blue200,
            title: 'Продолжить',
            assetIcon: '')
      ],
    );
  }
}
