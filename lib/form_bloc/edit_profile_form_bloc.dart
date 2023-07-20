import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_nurse_for_client/bloc/user_bloc.dart';
import 'package:private_nurse_for_client/helpers/validators.dart';
import 'package:private_nurse_for_client/models/emergency_relationship/emergency_relationship_model.dart';
import 'package:private_nurse_for_client/models/user/edit_profile_request_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/models/user/user_response_model.dart';


class EditProfileFormBloc extends FormBloc<UserModel, UserResponseModel> {
  UserBloc userBloc = new UserBloc();
  XFile? newProfilePhoto;

  //Name
  final newName = TextFieldBloc(
    validators: [
      InputValidator.nameChar,
    ],
  );
  //Email
   final newEmail = TextFieldBloc(
      // validators: [
      //   InputValidator.required,
      // ],
      );
 //IC
   final newIC = TextFieldBloc(
      // validators: [
      //   InputValidator.required,
      // ],
      );

  // Phone Number
  final phoneNo = TextFieldBloc(
    validators: [
      // InputValidator.required,
      InputValidator.phoneNo,
    ],
  );
 // Gender
  final gender = TextFieldBloc();
  // Get the integer value from the division field bloc
  int getDivisionValue() {
    final genderText = gender.value;
    if (genderText.isNotEmpty) {
      return int.parse(genderText);
    } else {
      // Handle the case when the division field is empty or invalid
      return 0; // Or any default value you want to use
    }
  }
  // Address
  final newAddress = TextFieldBloc(
      // validators: [
      //   InputValidator.required,
      // ],
      );
// Bank
  final newBank = TextFieldBloc(
      // validators: [
      //   InputValidator.required,
      // ],
      );
// Account
  final newAccount = TextFieldBloc(
      // validators: [
      //   InputValidator.required,
      // ],
      );

  
  // Check phone
  Future<String?> _checkPhoneNo(String phoneNo) async {
    bool isExist = await userBloc.checkPhoneNumber(phoneNo);
    if (isExist) {
      return "This phone number is already registered";
    }
    return null;
  }

  EditProfileFormBloc(UserModel userModel) {

    newName.updateInitialValue(userModel.name!);
    newEmail.updateInitialValue(userModel.email!);
    newIC.updateInitialValue(userModel.icNo!);
    phoneNo.updateInitialValue(userModel.phoneNo!);
    gender.updateInitialValue(userModel.genderId!.toString());
    newAddress.updateInitialValue(userModel.address!);
    newBank.updateInitialValue(userModel.bankModel!.name!);
    newAccount.updateInitialValue(userModel.accountNumber!);
    
   
    addFieldBlocs(fieldBlocs: [
      newName,
      newEmail,
      newIC,
      phoneNo,
      gender,
      newAddress,
      newBank,
      newAccount,
    ]);

  }

  @override
  Future<void> onSubmitting() async {
    try {
      //TODO: edit EditProfileRequestModel ikut formbloc
      EditProfileRequestModel requestModel = EditProfileRequestModel();

      requestModel.name = newName.value;
      requestModel.email = newEmail.value;
      requestModel.ic = newIC.value;
      requestModel.phoneNo = phoneNo.value;
      requestModel.gender = gender.value;
      requestModel.address = newAddress.value;
      requestModel.bank = newBank.value;
      requestModel.account = newAccount.value;
      requestModel.photoPath = newProfilePhoto;
     

      UserResponseModel responseModel =
          await userBloc.editProfile(requestModel);

      if (responseModel.isSuccess) {
        emitSuccess(successResponse: responseModel.data!);
      } else {
        emitFailure(failureResponse: responseModel.errors);
        print(responseModel.message);
      }
    } catch (e) {
      emitFailure(failureResponse: null);
    }
  }
}
