part of '../feature.dart';

class AddServicesScreenViewModel extends ChangeNotifier {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  FocusNode fullNameFocuseNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode commentFocusNode = FocusNode();
  List<String> files = [];
  String selectedProblem = '';

  bool checkForAllIsFilled() {
    return fullNameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        commentController.text.isNotEmpty &&
        selectedProblem.isNotEmpty;
  }
}
