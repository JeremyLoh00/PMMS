import 'dart:convert';
import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/password/change_password_model.dart';
import 'package:private_nurse_for_client/services/resource.dart';

class ChangePasswordResource {
  static Resource verifyPassword(String password) {
    return Resource(
        url: 'change-password/verify',
        data: {'email': password},
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  static Resource updatePassword(ChangePasswordRequestModel requestModel) {
    return Resource(
        url: 'change-password',
        data: requestModel.toJson(),
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }
}
