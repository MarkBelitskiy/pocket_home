part of '../feature.dart';

class _RegisterScreen extends StatelessWidget {
  const _RegisterScreen({super.key, required this.bloc});
  final MainScreenBloc bloc;
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CreatePasswordModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: getMainAppTheme(context).colors.bgColor,
      appBar: MainAppBar(
        title: 'Регистрация',
        customOnTap: () {
          if (vm.enumValue == RegisterScreenBodyEnums.password) {
            context.read<RegisterBloc>().add(ChangeBodyEvent(RegisterScreenBodyEnums.profile));
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
      body: MainAppBody(isDoubleBlob: false, children: [
        BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterChangeBodyState) {
              vm.enumValue = state.enumValue;
            }
            if (state is RegisterSuccesfullState) {
              Navigator.of(context).pop();
              bloc.add(OnInitAppEvent());
            }
          },
          builder: (contxt, state) {
            if (state is RegisterChangeBodyState) {
              return state.enumValue == RegisterScreenBodyEnums.password ? _CreatePasswordBody() : _CreateProfileBody();
            }
            return _CreateProfileBody();
          },
        )
      ]),
    );
  }
}
