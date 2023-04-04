import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';

import 'bloc/main_app_bottom_sheet_bloc.dart';

Future showMainAppBottomSheet(
  BuildContext contextFromScreen, {
  required String title,
  required List<String> items,
  bool isNeedSearch = false,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
    backgroundColor: getMainAppTheme(contextFromScreen).colors.bgColor,
    context: contextFromScreen,
    builder: (context) => _ModalBody(
      isNeedSearch: isNeedSearch,
      items: items,
      title: title,
    ),
  );
}

class _ModalBody extends StatelessWidget {
  const _ModalBody({
    required this.title,
    required this.isNeedSearch,
    required this.items,
  });
  final String title;
  final List<String> items;
  final bool isNeedSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BlocProvider<MainAppBottomSheetBloc>(
          create: (context) => MainAppBottomSheetBloc(items),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Row(
                children: [
                  const SizedBox(
                    width: 48,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: getMainAppTheme(context)
                          .textStyles
                          .body
                          .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                    ).tr(),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: SvgPicture.asset(
                        getMainAppTheme(context).icons.close,
                        color: getMainAppTheme(context).colors.mainTextColor,
                      ))
                ],
              ),
              BlocBuilder<MainAppBottomSheetBloc, MainAppBottomSheetState>(
                  buildWhen: (previous, current) => current is ElementsLoadedState,
                  builder: (context, state) {
                    if (state is ElementsLoadedState) {
                      return Flexible(
                        fit: FlexFit.loose,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isNeedSearch)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 50),
                                child: MainTextField(
                                  prefixIcon: getMainAppTheme(context).icons.search,
                                  textController: TextEditingController(),
                                  focusNode: FocusNode(),
                                  maxLines: 1,
                                  title: 'search',
                                  onChanged: (value) {
                                    context.read<MainAppBottomSheetBloc>().add(SearchItemsEvent(value));
                                  },
                                  clearAvailable: true,
                                ),
                              ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: ListView.separated(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  separatorBuilder: (context, index) {
                                    return Divider(color: getMainAppTheme(context).colors.borderColors);
                                  },
                                  shrinkWrap: true,
                                  itemCount: state.items.length,
                                  itemBuilder: (context, index) {
                                    final String item = state.items[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop(items.indexOf(item));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                item,
                                                style: getMainAppTheme(context)
                                                    .textStyles
                                                    .body
                                                    .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                                              ).tr(),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'choose',
                                                  style: getMainAppTheme(context)
                                                      .textStyles
                                                      .body
                                                      .copyWith(color: getMainAppTheme(context).colors.activeText),
                                                ).tr(),
                                                SvgPicture.asset(
                                                  getMainAppTheme(context).icons.chevronRight,
                                                  color: getMainAppTheme(context).colors.activeColor,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  })
            ],
          )),
    );
  }
}
