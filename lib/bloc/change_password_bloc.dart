import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/password/change_password_model.dart';
import 'package:private_nurse_for_client/resource/change_password_resource.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class ChangePasswordBloc {
  Future<DefaultResponseModel> verifyPassword(String password) async {
    return await WebService.post(
        ChangePasswordResource.verifyPassword(password));
  }

  Future<DefaultResponseModel> updatePassword(
      ChangePasswordRequestModel requestModel) async {
    return await WebService.post(
        ChangePasswordResource.updatePassword(requestModel));
  }
}
