import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/repository/repository.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/widgets/floating_button/bloc/floating_button_bloc.dart';
import 'package:pocket_home/common/widgets/floating_button/floating_button_access_enums.dart';
import 'package:pocket_home/common/repository/models/my_home_model.dart';
import 'package:pocket_home/screens/my_home_screen/src/bloc/my_houses_bloc.dart';

class MainAppFloatingButton extends StatelessWidget {
  const MainAppFloatingButton({
    super.key,
    required this.onTap,
    required this.enumValue,
  });
  final Function(HouseModel? currentHouse) onTap;
  final MainFloatingActionButton enumValue;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FloatingButtonBloc(
          enumValue: enumValue, myHousesBloc: context.read<MyHousesBloc>(), repository: context.read<Repository>())
        ..add(OnInitButtonEvent()),
      child: BlocBuilder<FloatingButtonBloc, FloatingButtonState>(
        buildWhen: (previous, current) => current is ShowButtonState,
        builder: (context, state) {
          if (state is ShowButtonState) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: FloatingActionButton(
                heroTag: enumValue,
                onPressed: () {
                  onTap.call(state.currentHouse);
                },
                backgroundColor: getMainAppTheme(context).colors.cardColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: getMainAppTheme(context).colors.borderColors)),
                child: SvgPicture.asset(
                  getMainAppTheme(context).icons.add,
                  color: getMainAppTheme(context).colors.iconOnButtonColor,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
