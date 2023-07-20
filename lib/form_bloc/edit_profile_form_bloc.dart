import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_nurse_for_client/bloc/user_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
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
  final gender = SelectFieldBloc(
    validators: [FieldBlocValidators.required],
    items: [
      'Female',
      'Male',
    ],
  );

  // Address
  final newAddress = TextFieldBloc(
      // validators: [
      //   InputValidator.required,
      // ],
      );
  final division = TextFieldBloc();
  // Get the integer value from the division field bloc
  int getDivisionValue() {
    final divisionText = division.value;
    if (divisionText.isNotEmpty) {
      return int.parse(divisionText);
    } else {
      // Handle the case when the division field is empty or invalid
      return 0; // Or any default value you want to use
    }
  }

  // city
  final cityModel = TextFieldBloc();
  // Get the integer value from the division field bloc
  int getCityValue() {
    final cityText = cityModel.value;
    if (cityText.isNotEmpty) {
      return int.parse(cityText);
    } else {
      // Handle the case when the division field is empty or invalid
      return 0; // Or any default value you want to use
    }
  }

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
    cityModel.updateInitialValue(userModel.worldCityId.toString());
    division.updateInitialValue(userModel.worldDivisionId.toString());
    newBank.updateInitialValue(userModel.bankModel!.name!);
    newAccount.updateInitialValue(userModel.accountNumber!);

    addFieldBlocs(fieldBlocs: [
      newName,
      newEmail,
      newIC,
      phoneNo,
      gender,
      newAddress,
      cityModel,
      division,
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
      if (gender.value == 'Female') {
        requestModel.gender = FEMALE.toString();
      }
      if (gender.value == 'Male') {
        requestModel.gender = MALE.toString();
      }
      requestModel.address = newAddress.value;
      requestModel.worldCityId = getCityValue().toString();
      requestModel.worldDivisionId = getDivisionValue().toString();
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
