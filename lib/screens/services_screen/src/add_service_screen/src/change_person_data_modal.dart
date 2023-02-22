import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';
import 'package:pocket_home/screens/services_screen/src/add_service_screen/feature.dart';
import 'package:provider/provider.dart';

Future showChangePersonDataBottomSheet(
  BuildContext contextFromScreen,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
    backgroundColor: getMainAppTheme(contextFromScreen).colors.bgColor,
    context: contextFromScreen,
    builder: (context) => ChangeNotifierProvider.value(
        value: contextFromScreen.read<AddServicesScreenViewModel>(), child: const _ModalBody()),
  );
}

class _ModalBody extends StatelessWidget {
  const _ModalBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AddServicesScreenViewModel>(context);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Row(
            children: [
              const SizedBox(
                width: 24,
              ),
              Expanded(
                child: Text(
                  'Изменение контактных данных',
                  textAlign: TextAlign.center,
                  style: getMainAppTheme(context)
                      .textStyles
                      .body
                      .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  icon: SvgPicture.asset(
                    getMainAppTheme(context).icons.close,
                    color: getMainAppTheme(context).colors.mainTextColor,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: MainTextField(
                textController: vm.fullNameController,
                focusNode: vm.fullNameFocuseNode,
                bgColor: getMainAppTheme(context).colors.buttonsColor,
                isPasswordField: false,
                maxLines: 1,
                title: 'ФИО',
                readOnly: false,
                onChanged: (value) {},
                clearAvailable: true,
                autoFocus: false),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: MainTextField(
                textController: vm.phoneController,
                focusNode: vm.phoneFocusNode,
                bgColor: getMainAppTheme(context).colors.buttonsColor,
                isPasswordField: false,
                maxLines: 1,
                keyboardType: TextInputType.phone,
                title: 'Телефон',
                readOnly: false,
                onChanged: (value) {},
                clearAvailable: true,
                autoFocus: false),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
            child: MainAppButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                title: 'Сохранить',
                assetIcon: ''),
          )
        ],
      ),
    );
  }
}
