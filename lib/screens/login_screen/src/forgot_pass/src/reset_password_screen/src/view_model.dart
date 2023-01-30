import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ResetPasswordModel extends ChangeNotifier {
  final passwordTextController = TextEditingController();
  final passwordFocusNode = FocusNode();

  final passwordRepeatTextController = TextEditingController();
  final passwordRepeatFocusNode = FocusNode();

  final _lengthHigherThen8 = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getLengthHigherThen8 => _lengthHigherThen8.stream;

  final _containsLatLettersAndNumbers = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getContainsLatLettersAndNumbers =>
      _containsLatLettersAndNumbers.stream;

  final _haveOneOrMoreCapitalLetter = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getHaveOneOrMoreCapitalLetter =>
      _haveOneOrMoreCapitalLetter.stream;

  final _validateAll = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getValidateAll => _validateAll.stream;

  final _validateAllWithoutCheckForSame = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getValidateAllWithoutCheckForSame =>
      _validateAllWithoutCheckForSame.stream;

  Stream<bool> get getPasswordsIsSame => _passwordsIsSame.stream;

  final _passwordsIsSame = BehaviorSubject<bool>.seeded(true);

  void init() {
    passwordTextController.addListener(() {
      setLengthHigherValue();
      setContainsLettersAndNumValue();
      setHaveOneOrMoreCapitalLetter();
      setValidateAllWithOutCheckForSame();
      setValidateAll();
      setPasswordsIsSame();
    });

    passwordFocusNode.addListener(() {
      setValidateAllWithOutCheckForSame();
    });

    passwordRepeatTextController.addListener(() {
      setValidateAll();
      setPasswordsIsSame();
    });
    // passwordFocusNode.addListener(() {
    //   if (!passwordFocusNode.hasFocus &&
    //       passwordTextController.text.isNotEmpty) {
    //     _validateAllWithoutCheckForSame.add(passwordTextController.text
    //         .contains(
    //             RegExp(r'(?=.*[0-9])(?=\S+$)(?=.*[A-z])(?=.*[A-Z]).{8,}')));
    //   }
    // });
  }

  void setPasswordsIsSame() {
    _passwordsIsSame
        .add(passwordRepeatTextController.text == passwordTextController.text);
  }

  void setLengthHigherValue() {
    _lengthHigherThen8
        .add(passwordTextController.text.contains(RegExp(r'.{7,}(?=\S+$)')));
  }

  void setContainsLettersAndNumValue() {
    _containsLatLettersAndNumbers.add(passwordTextController.text
        .contains(RegExp(r'(?=.*[0-9])(?=.*[A-z])')));
  }

  void setHaveOneOrMoreCapitalLetter() {
    _haveOneOrMoreCapitalLetter.add(passwordTextController.text
        .contains(RegExp(r'(?=.*[A-Z])(?=.*[a-z])')));
  }

  void setValidateAll() {
    _validateAll.add(passwordTextController.text.contains(
            RegExp(r'(?=.*[0-9])(?=\S+$)(?=.*[A-z])(?=.*[A-Z]).{8,}')) &&
        passwordTextController.text == passwordRepeatTextController.text);
  }

  void setValidateAllWithOutCheckForSame() {
    _validateAllWithoutCheckForSame.add(passwordTextController.text
        .contains(RegExp(r'(?=.*[0-9])(?=\S+$)(?=.*[A-z])(?=.*[A-Z]).{8,}')));
  }
}
