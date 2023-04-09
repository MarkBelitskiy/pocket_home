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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthorizedSuccessState) {
          Navigator.of(context).pop();
        }
        if (state is AuthorizedErrorState) {
          return returnSnackBar(context, state.error);
        }
      },
      child: Scaffold(
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        appBar: const MainAppBar(
          title: 'auth',
        ),
        body: MainAppBody(
          children: [
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
                if (loginController.text.isEmpty) {
                  return returnSnackBar(context, 'fillInLogginField');
                }
                if (passController.text.isEmpty || passController.text.length < 8) {
                  return returnSnackBar(context, 'fillInPasswordField');
                }

                context.read<AuthBloc>().add(LoginEvent(loginController.text, passController.text));
              },
              title: 'continue',
              titleColor: getMainAppTheme(context).colors.accentTextColor,
            )
          ],
        ),
      ),
    );
  }
}
