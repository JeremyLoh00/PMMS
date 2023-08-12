import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/helpers/secure_storage_api.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/resource/user_resource.dart';

class UserDataNotifier with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUserData(UserModel? userModel) async {
     _user = userModel;
    //save in secured storage
    await SecureStorageApi.saveObject("user", userModel);
    //save in GetIt
    UserResource.setGetIt(userModel!);
    notifyListeners();
  }
  void setUser(UserModel? userModel) {
    _user = userModel;
   
  }
}
