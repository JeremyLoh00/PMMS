import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/password/forgot_password_request_model.dart';
import 'package:private_nurse_for_client/resource/forgot_password_resource.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class ForgotPasswordBloc {
  Future<DefaultResponseModel> verifyEmail(String email) async {
    return await WebService.post(ForgotPasswordResource.sendOTP(email));
  }

  Future<DefaultResponseModel> verifyOTP(String email, String otp) async {
    return await WebService.post(ForgotPasswordResource.verifyOTP(email, otp));
  }

  Future<DefaultResponseModel> updatePassword(
      ForgotPasswordRequestModel requestModel) async {
    return await WebService.post(
        ForgotPasswordResource.updatePassword(requestModel));
  }
}
