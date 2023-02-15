import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pocket_home/common/theme/theme_getter.dart';
import 'package:pocket_home/common/widgets/button_widget.dart';
import 'package:pocket_home/common/widgets/main_app_bar_widget.dart';
import 'package:pocket_home/common/widgets/main_body_widget.dart';
import 'package:pocket_home/notification_service.dart';
import 'package:rxdart/rxdart.dart';

part 'src/otp_screen.dart';

CupertinoPageRoute otpScreenRoute(String phone, Function(OtpReturnDataModel) continueButtonCallBack) {
  return CupertinoPageRoute(
    builder: (context) {
      return OtpScreen(
        phone: phone,
        continueButtonCallBack: continueButtonCallBack,
      );
    },
  );
}

class OtpReturnDataModel {
  final String phone;
  final String messageId;
  final String smsCode;

  OtpReturnDataModel(this.phone, this.messageId, this.smsCode);
}
