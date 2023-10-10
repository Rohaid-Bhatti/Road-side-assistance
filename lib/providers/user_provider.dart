import 'package:flutter/material.dart';
import 'package:home_hub/const/firebase_const.dart';
import 'package:home_hub/models/user_model.dart';

class UserProvider with ChangeNotifier {

  late UserModel currentData;

  void getUserData() async {
    UserModel userModel;
    var value = await firestore
        .collection(usersCollection)
        .doc(auth.currentUser!.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
        name: value.get("name"),
        email: value.get("email"),
        image: value.get("image"),
        uid: value.get("uid"),
        phoneNumber: value.get("phoneNumber"),
        password: value.get("password"),
        deviceToken: value.get("deviceToken"),
      );
      currentData = userModel;
      notifyListeners();
    }
  }

  UserModel get currentUserData {
    return currentData;
  }
}