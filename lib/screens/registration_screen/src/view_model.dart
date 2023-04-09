import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_home/screens/registration_screen/src/body_enums.dart';
import 'package:rxdart/rxdart.dart';

class CreatePasswordModel extends ChangeNotifier {
  RegisterScreenBodyEnums enumValue = RegisterScreenBodyEnums.profile;

  String photoPath = '';

  final passwordTextController = TextEditingController();
  final passwordFocusNode = FocusNode();

  final phoeTextController = TextEditingController();
  final phoneFocus = FocusNode();

  final loginTextController = TextEditingController();
  final loginFocus = FocusNode();

  final nameTextController = TextEditingController();
  final nameFocus = FocusNode();

  final passwordRepeatTextController = TextEditingController();
  final passwordRepeatFocusNode = FocusNode();

  final _lengthHigherThen8 = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getLengthHigherThen8 => _lengthHigherThen8.stream;

  final _containsLatLettersAndNumbers = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getContainsLatLettersAndNumbers => _containsLatLettersAndNumbers.stream;

  final _haveOneOrMoreCapitalLetter = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getHaveOneOrMoreCapitalLetter => _haveOneOrMoreCapitalLetter.stream;

  final _validateAll = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getValidateAll => _validateAll.stream;

  void init() {
    passwordTextController.addListener(() {
      setLengthHigherValue();
      setContainsLettersAndNumValue();
      setHaveOneOrMoreCapitalLetter();
      setValidateAll();
    });

    passwordRepeatTextController.addListener(() {
      setValidateAll();
    });
  }

  void setLengthHigherValue() {
    _lengthHigherThen8.add(passwordTextController.text.contains(RegExp(r'.{7,}(?=\S+$)')));
  }

  void setContainsLettersAndNumValue() {
    _containsLatLettersAndNumbers.add(passwordTextController.text.contains(RegExp(r'(?=.*[0-9])(?=.*[A-z])')));
  }

  void setHaveOneOrMoreCapitalLetter() {
    _haveOneOrMoreCapitalLetter.add(passwordTextController.text.contains(RegExp(r'(?=.*[A-Z])(?=.*[a-z])')));
  }

  void setValidateAll() {
    _validateAll.add(passwordTextController.text.contains(RegExp(r'(?=.*[0-9])(?=\S+$)(?=.*[A-z])(?=.*[A-Z]).{8,}')) &&
        passwordTextController.text == passwordRepeatTextController.text);
  }
}
