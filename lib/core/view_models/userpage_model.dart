import 'package:flutter/cupertino.dart';

class UserPageModel extends ChangeNotifier {
  List<String> selectedUsers = [];
  List<String> selectedUsersNames = [];

  longPressFunction(String profileUserId, String nameAndSurname) {
    if (!this.selectedUsers.contains(profileUserId)) {
      this.selectedUsers.add(profileUserId);
      this.selectedUsersNames.add(nameAndSurname);
      notifyListeners();
    }
  }

  onTapFunction(String profileUserId, String nameAndSurname) {
    if (this.selectedUsers.contains(profileUserId)) {
      this.selectedUsers.removeWhere((val) => val == profileUserId);
      this.selectedUsersNames.removeWhere((val) => val == nameAndSurname);
      notifyListeners();
    }
  }
}
