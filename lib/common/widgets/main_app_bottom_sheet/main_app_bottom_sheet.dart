import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';

Future showMainAppBottomSheet(BuildContext context,
    {required String title, required List<String> items}) {
  return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      backgroundColor: getMainAppTheme(context).colors.bgColor,
      context: context,
      builder: (context) => _ModalBody(
            items: items,
            title: title,
          ));
}

class _ModalBody extends StatelessWidget {
  const _ModalBody({super.key, required this.title, required this.items});
  final String title;
  final List<String> items;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                title,
                textAlign: TextAlign.center,
                style: getMainAppTheme(context).textStyles.body.copyWith(
                    color: getMainAppTheme(context).colors.mainTextColor),
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
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 50),
          child: MainTextField(
              prefixIcon: getMainAppTheme(context).icons.search,
              textController: TextEditingController(),
              focusNode: FocusNode(),
              bgColor: getMainAppTheme(context).colors.buttonsColor,
              isPasswordField: false,
              maxLines: 1,
              title: 'Поиск',
              readOnly: false,
              onChanged: (value) {},
              clearAvailable: true,
              autoFocus: false),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final String item = items[index];
                return Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  color: getMainAppTheme(context).colors.buttonsColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item,
                          style: getMainAppTheme(context)
                              .textStyles
                              .body
                              .copyWith(
                                  color: getMainAppTheme(context)
                                      .colors
                                      .mainTextColor),
                        ),
                      ),
                      SvgPicture.asset(
                        getMainAppTheme(context).icons.chevronDown,
                        color: getMainAppTheme(context).colors.mainTextColor,
                      )
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }
}
