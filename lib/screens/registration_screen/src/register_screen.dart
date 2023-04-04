part of '../feature.dart';

class _RegisterScreen extends StatelessWidget {
  const _RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CreatePasswordModel>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: getMainAppTheme(context).colors.bgColor,
        appBar: MainAppBar(
          title: 'registerTitle',
          customOnTap: () {
            Navigator.of(context).pop();
          },
        ),
        body: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterChangeBodyState) {
              vm.enumValue = state.enumValue;
            }
            if (state is RegisterSuccesfullState) {
              context.read<AuthBloc>().add(InitAuthEvent());
              Navigator.of(context).pop();
            }
          },
          builder: (contxt, state) {
            if (state is RegisterChangeBodyState) {
              return state.enumValue == RegisterScreenBodyEnums.password
                  ? const _CreatePasswordBody()
                  : const _CreateProfileBody();
            }
            return const _CreateProfileBody();
          },
        ));
  }
}
