import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/utils/colors_palette.dart';
import 'package:pocket_home/common/utils/formatter_utils.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({
    Key? key,
    required this.textController,
    required this.focusNode,
    this.title,
    this.isPasswordField = false,
    this.errorText,
    this.maxLines = 1,
    this.readOnly = false,
    this.onChanged,
    this.clearAvailable = true,
    this.prefixIcon,
    this.stringToValidate,
    this.regExpToValidate,
    this.textInputAction,
    this.keyboardType,
  })  : assert(
            !(regExpToValidate != null && stringToValidate != null), 'You can use only one of this fields to validate'),
        assert(!(isPasswordField && clearAvailable), 'If you use isPasswordField set clearAvailable to false'),
        assert(!(errorText == null && (regExpToValidate != null || stringToValidate != null)),
            'You need set errorText to show message on the screen'),
        assert(!(errorText != null && (regExpToValidate == null && stringToValidate == null)),
            'If you want show error message use regExpToValidate or stringToValidate'),
        super(key: key);
  final TextEditingController textController;
  final FocusNode focusNode;
  final bool clearAvailable;

  final bool isPasswordField;
  final String? title;
  final String? errorText;
  final int? maxLines;
  final bool readOnly;
  final RegExp? regExpToValidate;
  final String? stringToValidate;
  final String? prefixIcon;
  final dynamic textInputAction;

  final Function(String value)? onChanged;

  final TextInputType? keyboardType;

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  late bool showSuffixIcon;
  bool isValidate = false;
  late bool isPhoneField;
  final mask = FormatterUtils.phoneFormatter;

  @override
  void initState() {
    showSuffixIcon = widget.isPasswordField;
    isPhoneField = widget.keyboardType == TextInputType.phone;

    super.initState();
  }

  @override
  void dispose() {
    widget.textController.dispose();
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //TODO ADD TITLE
        TextFormField(
          keyboardType: widget.keyboardType,
          readOnly: widget.readOnly,
          autocorrect: false,
          textInputAction: widget.textInputAction ?? TextInputAction.done,
          inputFormatters: isPhoneField ? [mask] : null,
          validator: (value) {
            return _validateFunc(value);
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            if (_validateFunc(value) == null) {
              setState(() {
                isValidate = value.isNotEmpty;
                if (!widget.isPasswordField) {
                  showSuffixIcon = value.isNotEmpty;
                }
              });
            } else {
              setState(() {
                isValidate = false;
                if (!widget.isPasswordField) {
                  showSuffixIcon = value.isNotEmpty;
                }
              });
            }

            widget.onChanged?.call(value);
          },
          maxLines: widget.maxLines,
          obscureText: widget.isPasswordField && showSuffixIcon,
          controller: widget.textController,
          style:
              getMainAppTheme(context).textStyles.body.copyWith(color: getMainAppTheme(context).colors.mainTextColor),
          focusNode: widget.focusNode,
          cursorColor: getMainAppTheme(context).colors.mainTextColor,
          decoration: InputDecoration(
            filled: true,
            fillColor: getMainAppTheme(context).colors.cardColor,
            prefixIcon: widget.prefixIcon != null ? SvgPicture.asset(widget.prefixIcon!, width: 24, height: 24) : null,
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    constraints: const BoxConstraints(maxWidth: 24, maxHeight: 24),
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                        showSuffixIcon
                            ? getMainAppTheme(context).icons.eyeOpen
                            : getMainAppTheme(context).icons.eyeClose,
                        color: ColorPalette.blue500,
                        width: 24,
                        height: 24),
                    onPressed: () {
                      setState(() {
                        showSuffixIcon = !showSuffixIcon;
                      });
                    },
                  )
                : showSuffixIcon && widget.clearAvailable
                    ? IconButton(
                        constraints: const BoxConstraints(maxWidth: 24, maxHeight: 24),
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(getMainAppTheme(context).icons.close,
                            color: getMainAppTheme(context).colors.borderColors, width: 24, height: 24),
                        onPressed: () {
                          widget.textController.clear();
                          widget.onChanged?.call('');
                          showSuffixIcon = false;
                        },
                      )
                    : null,
            labelStyle: getMainAppTheme(context)
                .textStyles
                .subBody
                .copyWith()
                .copyWith(color: getMainAppTheme(context).colors.mainTextColor),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: widget.errorText != null && isValidate ? ColorPalette.green500 : ColorPalette.grey600,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: ColorPalette.blue500,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: ColorPalette.red500,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: ColorPalette.red500,
                width: 1,
              ),
            ),
          ),
        )
      ],
    );
  }

  String? _validateFunc(String? value) {
    if (value != null && value.isNotEmpty) {
      if (widget.regExpToValidate != null && !value.contains(widget.regExpToValidate!)) {
        return widget.errorText;
      }
      if (widget.stringToValidate != null && value != widget.stringToValidate!) {
        return widget.errorText;
      }
    }
    return null;
  }
}
