import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:private_nurse_for_client/helpers/http_response.dart';
import 'package:private_nurse_for_client/helpers/secure_storage_api.dart';
import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/login/login_request_model.dart';
import 'package:private_nurse_for_client/models/registration/register_nurse_request_model.dart';
import 'package:private_nurse_for_client/models/uniform_fee_payment_request_model.dart/uniform_fee_payment_request_model.dart';
import 'package:private_nurse_for_client/models/user/edit_profile_request_model.dart';
import 'package:private_nurse_for_client/models/user/user_response_model.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/resource/uniform_fee_payment_resource.dart';
import 'package:private_nurse_for_client/resource/user_resource.dart';
import 'package:private_nurse_for_client/screens/sign_in/sign_in_screen.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class UserBloc {
  Future<bool> checkEmail(String email) async {
    final DefaultResponseModel response =
        await WebService.get(UserResource.checkEmail(email));

    //if true then exist, or else
    return response.isSuccess;
  }

  Future<bool> checkIcNumber(String icNo) async {
    final DefaultResponseModel response =
        await WebService.get(UserResource.checkIcNumber(icNo));

    //if true then exist, or else
    return response.isSuccess;
  }

  Future<bool> checkPhoneNumber(String phoneNo) async {
    final DefaultResponseModel response =
        await WebService.get(UserResource.checkPhoneNumber(phoneNo));

    //if true then exist, or else
    return response.isSuccess;
  }

  Future<bool> checkHeroCode(String heroCode) async {
    final DefaultResponseModel response =
        await WebService.get(UserResource.checkHeroCode(heroCode));

    //if true then exist, or else
    return response.isSuccess;
  }

  Future<DefaultResponseModel> checkDiscountCode(String discountCode) async {
    final DefaultResponseModel response =
        await WebService.get(UserResource.checkDiscountCode(discountCode));

    return response;
  }

  // Registration user
  Future<DefaultResponseModel> register(
      RegisterClientRequestModel requestModel) async {
    // Call the API to register
    return await WebService.registerFileUser(
      UserResource.register(requestModel),
      requestModel,
    );
  }

  // payment Registration
  Future<DefaultResponseModel> uniformFeePayment(
      UniformFeePaymentRequestModel requestModel) async {
    // Call the API to pay uniform
    return await WebService.post(
      UniformFeePaymentResource.uniformFeePayment(requestModel),
    );
  }

  // Verify OTP number and marked user email as verified
  Future<DefaultResponseModel> verifyEmail(String email, String otp) async {
    // Call the API to register
    return await WebService.post(UserResource.verifyEmail(email, otp));
  }

  // Edit Profile
  // Future<UserResponseModel> editProfile(EditProfileRequestModel editProfileRequestModel) async {
  //   // Call the API to edit profile
  //   return await Webservice.put(UserResource.editProfile(editProfileRequestModel));
  // }

  // Resent OTP number to marked email as verified
  Future<DefaultResponseModel> resendEmail(
    String email,
  ) async {
    // Call the API to register
    return await WebService.post(UserResource.resendEmail(email));
  }

// Sign out
  Future<DefaultResponseModel> signOut(context) async {
    // Revoked User Token
    DefaultResponseModel defaultResponseModel =
        await WebService.get(UserResource.logout());
    print(defaultResponseModel.toJson());
    // If success or already unauthorized clear data in storage
    if (defaultResponseModel.isSuccess ||
        defaultResponseModel.statusCode == HttpResponse.HTTP_UNAUTHORIZED) {
      await GetIt.instance.reset();
      await SecureStorageApi.delete(key: "access_token");

      print(SignInScreen.routeName);

      // Navigate to Sign In Screen
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (Route<dynamic> route) => false);

      ThemeSnackBar.showSnackBar(context, "You're logged out.");
    } else {
      Navigator.pop(context);
      Navigator.pop(context);
      ThemeSnackBar.showSnackBar(context, defaultResponseModel.message);
      print(defaultResponseModel.message);
    }

    return defaultResponseModel;
  }

  // Login
  Future<UserResponseModel> login(LoginRequestModel loginModel) async {
    // Call the API to login
    final UserResponseModel response =
        await WebService.post(UserResource.login(loginModel));

    if (response.statusCode == HttpResponse.HTTP_OK) {
      if (response.data != null && response.data?.accessToken != null) {
        //save in secured storage
        await SecureStorageApi.write(
            key: "access_token", value: response.data!.accessToken!);
        //save in secured storage
        await SecureStorageApi.saveObject("user", response.data);
        //save in GetIt
        UserResource.setGetIt(response.data!);
      }
    }
    return response;
  }

// edit profile
  Future<UserResponseModel> editProfile(
      EditProfileRequestModel requestModel) async {
    // Call the API to edit profile
    try {
      final UserResponseModel response = await WebService.postUpdateUser(
          UserResource.editProfile(requestModel), requestModel);
      if (response.statusCode == HttpResponse.HTTP_OK) {
        //save in secured storage
        await SecureStorageApi.saveObject("user", response.data);
        //save in GetIt
        UserResource.setGetIt(response.data!);
      }
      return response;
    } catch (e) {
      print(e);
    }
    return UserResponseModel(null);
  }

  // Get latest user data
  Future<UserResponseModel> me(BuildContext context) async {
    // Call the API to register
    UserResponseModel responseModel = await WebService.get(UserResource.me());
    // Means token already invalid
    if (responseModel.statusCode == HttpResponse.HTTP_UNAUTHORIZED) {
      // Logout user
      signOut(context);
    } else if (responseModel.isSuccess) {
      //save in secured storage
      await SecureStorageApi.saveObject("user", responseModel.data);
      //save in GetIt
      UserResource.setGetIt(responseModel.data!);
    }
    return responseModel;
  }

  // delete account
  Future<DefaultResponseModel> deleteAccount() async {
    // Call the API to delete account
    return await WebService.delete(UserResource.deleteProfile());
  }
}
