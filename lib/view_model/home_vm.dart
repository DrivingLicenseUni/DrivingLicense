import 'package:flutter/material.dart';

import '../data/remote/home_v_data.dart';

class HomeViewModel with ChangeNotifier {
  String userName = "";
  String userImage = "";

  Future<void> fetchUserData(String userId) async {
    var userData = await FirebaseService.getUserData(userId);

    userName = userData?['name'];
    userImage = userData?['image'];
    notifyListeners();
  }

  void onCategoryTap(BuildContext context, Widget destinationPage) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => destinationPage));
  }
}
