import 'package:flutter/material.dart';

class AddNewWorkersViewModel extends ChangeNotifier {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sallaryController = TextEditingController();
  FocusNode fullNameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode sallaryFocusNode = FocusNode();
  //TODO вынести в префы + перевод
  List<String> jobTitles = ['Дворник', 'Слесарь', 'Электрик'];
  String currentJobTitle = '';
  void setCurrentJobTitle(int value) {
    currentJobTitle = jobTitles[value];
    notifyListeners();
  }
}
