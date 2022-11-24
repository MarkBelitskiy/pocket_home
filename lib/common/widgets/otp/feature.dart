import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rxdart/rxdart.dart';

part 'src/otp_screen.dart';

CupertinoPageRoute otpScreenRoute(String phone, String smsType,
    Function(OtpReturnDataModel) continueButtonCallBack) {
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
