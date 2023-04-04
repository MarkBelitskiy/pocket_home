part of '../feature.dart';

class _LoginScreen extends StatefulWidget {
  const _LoginScreen({Key? key}) : super(key: key);

  @override
  State<_LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<_LoginScreen> {
  final loginController = TextEditingController();
  final passController = TextEditingController();
  final loginFocus = FocusNode();
  final passFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        appBar: const MainAppBar(
          title: 'auth',
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            // if (state is AuthorizedSuccessState) {
            //   Navigator.of(context).pop();
            //   context.read<MyHousesBloc>().add(InitHousesEvent());
            // }
          },
          child: MainAppBody(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            MainTextField(
              title: 'login',
              textController: loginController,
              focusNode: loginFocus,
            ),
            const SizedBox(
              height: 24,
            ),
            MainTextField(
              title: 'pass',
              textController: passController,
              focusNode: passFocus,
              isPasswordField: true,
              clearAvailable: false,
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(forgotPassScreenFeature());
              },
              child: Text(
                'forgotPass',
                style: getMainAppTheme(context).textStyles.body.copyWith(
                      color: ColorPalette.red500,
                    ),
              ).tr(),
            ),
            const SizedBox(
              height: 32,
            ),
            MainAppButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LoginEvent(loginController.text, passController.text));
                },
                title: 'continue',
                titleColor: ColorPalette.blue200,
                assetIcon: '')
          ]),
        ));
  }
}
