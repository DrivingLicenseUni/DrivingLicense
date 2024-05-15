import 'package:flutter/material.dart';
import 'package:license/model/participating_user.dart';

class StudentProgressListViewModel extends ChangeNotifier {
  List<UserModel> userList = [
    UserModel(avatarText: 'A', title: 'User 1', subtitle: 'calculate progress'),
    UserModel(avatarText: 'B', title: 'User 2', subtitle: '-'),
    UserModel(avatarText: 'C', title: 'User 3', subtitle: '-'),
  ];
  final VoidCallback onUserAdded;

  StudentProgressListViewModel({required this.onUserAdded});

  void addUser() {
    userList.add(UserModel(
      avatarText: String.fromCharCode('A'.codeUnitAt(0) + userList.length),
      title: 'User ${userList.length + 1}',
      subtitle: '-',
    ));
    // Call the callback to notify the UI that a user is added
    onUserAdded();
  }


}
