import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/utils/formatter_utils.dart';

class MainTextField extends StatefulWidget {
  const MainTextField(
      {Key? key,
      required this.textController,
      required this.focusNode,
      required this.bgColor,
      this.title,
      required this.isPasswordField,
      this.errorText,
      required this.maxLines,
      this.borderColors,
      this.onTap,
      required this.readOnly,
      required this.onChanged,
      required this.clearAvailable,
      this.prefixIcon,
      this.suffixIcon,
      required this.autoFocus,
      this.textInputAction,
      this.keyboardType,
      this.onSubmitted})
      : super(key: key);
  final TextEditingController textController;
  final FocusNode focusNode;

  final bool clearAvailable;
  final bool autoFocus;
  final Color? borderColors;
  final Color bgColor;
  final bool isPasswordField;
  final String? title;
  final String? errorText;
  final int? maxLines;
  final bool readOnly;
  final String? suffixIcon;
  final String? prefixIcon;
  final dynamic textInputAction;
  final Function(String value)? onSubmitted;
  final Function(String value)? onChanged;
  final Function? onTap;
  final TextInputType? keyboardType;

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  final borderStyle = InputBorder.none;
  Color? _borderColor;

  late FocusNode focusNode;
  late TextEditingController textEditingController;
  late ValueNotifier<bool> _showSuffixIcon;

  bool isPhoneField = false;
  final mask = FormatterUtils.phoneFormatter;
  @override
  void initState() {
    isPhoneField = widget.keyboardType == TextInputType.phone;
    focusNode = widget.focusNode;
    focusNode.addListener(() {
      setState(() {
        _borderColor = widget.errorText != null && textEditingController.text.isNotEmpty && !focusNode.hasFocus
            ? ColorPalette.red500
            : focusNode.hasFocus
                ? ColorPalette.blue500
                : Colors.transparent;
      });
    });
    textEditingController = widget.textController;

    _showSuffixIcon = ValueNotifier<bool>(widget.isPasswordField);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
        widget.onTap?.call();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(minHeight: 60),
            decoration: BoxDecoration(
                color: widget.bgColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: widget.borderColors ?? _borderColor ?? Colors.transparent)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                if (widget.prefixIcon != null) ...[
                  SvgPicture.asset(widget.prefixIcon!, width: 24, height: 24),
                  const SizedBox(
                    width: 8,
                  )
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueListenableBuilder<bool>(
                          valueListenable: _showSuffixIcon,
                          builder: (context, value, child) {
                            return TextFormField(
                              keyboardType: widget.keyboardType,
                              readOnly: widget.readOnly,
                              autocorrect: false,
                              textInputAction: widget.textInputAction ?? TextInputAction.done,
                              onFieldSubmitted: (value) {
                                widget.onSubmitted?.call(value);
                              },
                              inputFormatters: isPhoneField ? [mask] : null,
                              onChanged: (value) {
                                if (!widget.isPasswordField) {
                                  _showSuffixIcon.value = value.isNotEmpty;
                                }
                                widget.onChanged?.call(value);
                              },
                              maxLines: widget.maxLines ?? 1,
                              autofocus: widget.autoFocus,
                              obscureText: widget.isPasswordField && value,
                              controller: textEditingController,
                              style: getMainAppTheme(context)
                                  .textStyles
                                  .body
                                  .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                              focusNode: focusNode,
                              cursorColor: getMainAppTheme(context).colors.mainTextColor,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: widget.title,
                                labelStyle: getMainAppTheme(context)
                                    .textStyles
                                    .subBody
                                    .copyWith()
                                    .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
                                contentPadding: EdgeInsets.zero,
                                border: borderStyle,
                                disabledBorder: borderStyle,
                                enabledBorder: borderStyle,
                                focusedBorder: borderStyle,
                                errorBorder: borderStyle,
                                focusedErrorBorder: borderStyle,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                if (widget.suffixIcon == null)
                  ValueListenableBuilder<bool>(
                      valueListenable: _showSuffixIcon,
                      builder: (context, value, child) {
                        if (widget.isPasswordField) {
                          return IconButton(
                            constraints: const BoxConstraints(maxWidth: 24, maxHeight: 24),
                            padding: EdgeInsets.zero,
                            icon: SvgPicture.asset(
                                value
                                    ? getMainAppTheme(context).icons.eyeOpen
                                    : getMainAppTheme(context).icons.eyeClose,
                                color: ColorPalette.blue500,
                                width: 24,
                                height: 24),
                            onPressed: () {
                              _showSuffixIcon.value = !_showSuffixIcon.value;
                            },
                          );
                        }
                        if (value && widget.clearAvailable) {
                          return IconButton(
                            constraints: const BoxConstraints(maxWidth: 24, maxHeight: 24),
                            padding: EdgeInsets.zero,
                            icon: SvgPicture.asset(getMainAppTheme(context).icons.close,
                                color: getMainAppTheme(context).colors.borderColors, width: 24, height: 24),
                            onPressed: () {
                              textEditingController.clear();
                              widget.onChanged?.call('');
                              _showSuffixIcon.value = false;
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                if (widget.suffixIcon != null) SvgPicture.asset(widget.suffixIcon!, width: 24, height: 24),
              ],
            ),
          ),
          if (widget.errorText != null && textEditingController.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                widget.errorText!,
                style: getMainAppTheme(context).textStyles.subBody.copyWith(color: ColorPalette.red500),
                textAlign: TextAlign.start,
              ),
            ),
        ],
      ),
    );
  }
}
