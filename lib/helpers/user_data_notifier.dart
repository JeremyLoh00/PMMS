import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';

class UserDataNotifier with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUserData(UserModel? userModel) {
    _user = userModel;
    notifyListeners();
  }
}
