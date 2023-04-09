import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:pocket_home/common/theme/main_app_theme/main_app_theme_view_model.dart';

import 'package:pocket_home/common/utils/formatter_utils.dart';

import 'package:pocket_home/common/widgets/main_text_field/main_text_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late SharedPreferences preferences;
  setUp(() async {
    preferences = await SharedPreferences.getInstance();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
  });

  group('MainTextField', () {
    testWidgets('text input can be validated', (tester) async {
      const errorMessage = 'This is an error';

      await tester.pumpWidget(ChangeNotifierProvider<MainAppThemeViewModel>(
        create: (context) => MainAppThemeViewModel()..init(preferences),
        child: MaterialApp(
          home: Scaffold(
            body: MainTextField(
              textController: textEditingController,
              focusNode: focusNode,
              errorText: errorMessage,
              regExpToValidate: RegExp('^[0-9]*\$'),
            ),
          ),
        ),
      ));

      await tester.enterText(find.byType(TextFormField), '123');
      await tester.pumpAndSettle();

      expect(find.text(errorMessage), findsNothing);

      await tester.enterText(find.byType(TextFormField), 'abc');
      await tester.pumpAndSettle();

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('phone number input is formatted correctly', (tester) async {
      final mask = FormatterUtils.phoneFormatter;
      const phoneNumber = '1234567890';

      await tester.pumpWidget(
        ChangeNotifierProvider<MainAppThemeViewModel>(
            create: (context) => MainAppThemeViewModel()..init(preferences),
            child: MaterialApp(
              home: Scaffold(
                body: MainTextField(
                  textController: textEditingController,
                  focusNode: focusNode,
                  keyboardType: TextInputType.phone,
                ),
              ),
            )),
      );

      await tester.enterText(find.byType(TextFormField), phoneNumber);
      await tester.pumpAndSettle();

      expect(textEditingController.text, mask.maskText(phoneNumber));
    });
  });
}
