part of '../feature.dart';

class AddServicesScreenViewModel extends ChangeNotifier {
  late UserModel currentUser;
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

  void init(UserModel currentUser) {
    currentUser = currentUser;
    fullNameController.text = currentUser.name;
    phoneController.text = currentUser.phone;
  }
}
