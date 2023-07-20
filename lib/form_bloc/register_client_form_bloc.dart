import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:private_nurse_for_client/bloc/user_bloc.dart';
import 'package:private_nurse_for_client/helpers/validators.dart';
import 'package:private_nurse_for_client/models/bank/bank_model.dart';
import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/gender/gender_model.dart';
import 'package:private_nurse_for_client/models/registration/register_nurse_request_model.dart';

class RegisterClientFormBloc extends FormBloc<String, String> {
  // Initialize Bloc
  final UserBloc userBloc = UserBloc();
  XFile? newProfilePhoto;

  // Name
  final name = TextFieldBloc(
    initialValue: "izzat",
    validators: [
      InputValidator.required,
      InputValidator.nameChar,
    ],
  );

  // Phone Number
  final phoneNo = TextFieldBloc(
    initialValue: "0132961685",
    validators: [
      // InputValidator.required,
      InputValidator.phoneNo,
    ],
  );

  // State
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

  // Bank
  final bank = SelectFieldBloc<BankModel, dynamic>();

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

  // gender
  final gender = SelectFieldBloc<GenderModel, dynamic>(
    validators: [FieldBlocValidators.required],
  );

  // Email
  final email = TextFieldBloc(
    initialValue: "nafizmansor25@gmail.com",
    validators: [
      InputValidator.required,
      InputValidator.emailChar,
    ],
  );

  final icNo = TextFieldBloc(initialValue: "000909101007");

  // Address
  final address = TextFieldBloc(initialValue: "No 26 Jalan Ikan"
      // validators: [
      //   InputValidator.required,
      // ],
      );

  // Bank account
  final accountNo = TextFieldBloc(
    initialValue: "000909101007",
    validators: [
      InputValidator.required,
    ],
  );

  // Password
  final password = TextFieldBloc(
    initialValue: "12121212",
    validators: [
      InputValidator.required,
      InputValidator.passwordChar,
    ],
  );

  // Check Email
  Future<String?> _checkEmail(String email) async {
    bool isExist = await userBloc.checkEmail(email);
    if (isExist) {
      return "This email is already registered";
    }
    return null;
  }

  // Check Email
  Future<String?> _checkIcNumber(String icNo) async {
    bool isExist = await userBloc.checkIcNumber(icNo);
    if (isExist) {
      return "This IC number is already registered";
    }
    return null;
  }

  // Check phone
  Future<String?> _checkPhoneNo(String phoneNo) async {
    bool isExist = await userBloc.checkPhoneNumber(phoneNo);
    if (isExist) {
      return "This phone number is already registered";
    }
    return null;
  }

  Validator<String> _confirmPassword(
    TextFieldBloc passwordTextFieldBloc,
  ) {
    return (String confirmPassword) {
      if (confirmPassword == passwordTextFieldBloc.value) {
        return null;
      }
      return "Your password does not match";
    };
  }

  Future<String> encodeFile(XFile filePath) async {
    File file = File(filePath.path);
    Uint8List bytes = file.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    print(base64Image);
    return base64Image;
  }

  RegisterClientFormBloc() {
    addFieldBlocs(fieldBlocs: [
      name,
      email,
      password,
      icNo,
      phoneNo,
      gender,
      address,
      division,
      cityModel,
      bank,
      accountNo,
    ]);

    //update gender
    GenderModel initGenderModel = GenderModel(id: 1, name: "Male");
    gender.updateItems([initGenderModel, GenderModel(id: 2, name: "Female")]);
    gender.updateInitialValue(initGenderModel);

    // Upadate Bank Items
    BankModel initBankModel = BankModel(id: 1, name: "Maybank2U");
    bank.updateItems([
      initBankModel,
      BankModel(id: 2, name: "CIMB Bank"),
      BankModel(id: 3, name: "Bank Islam"),
      BankModel(id: 4, name: "Public Bank"),
      BankModel(id: 5, name: "Hong Leong Bank"),
      BankModel(id: 6, name: "RHB Bank"),
      BankModel(id: 7, name: "Ambank"),
      BankModel(id: 8, name: "Bank Rakyat"),
      BankModel(id: 9, name: "Alliance Bank"),
      BankModel(id: 10, name: "Affin Bank"),
      BankModel(id: 11, name: "Bank Muamalat"),
      BankModel(id: 12, name: "Bank Simpanan Nasional"),
      BankModel(id: 13, name: "Standard Chartered"),
      BankModel(id: 14, name: "OCBC Bank"),
      BankModel(id: 15, name: "Agro Bank"),
      BankModel(id: 16, name: "UOB Bank"),
      BankModel(id: 17, name: "HSBC"),
      BankModel(id: 18, name: "Kuwait Finance House"),
      BankModel(id: 19, name: "CIMB Islamic Bank"),
      BankModel(id: 20, name: "Maybank2E"),
      BankModel(id: 21, name: "Al Rajhi Bank"),
      BankModel(id: 22, name: "Citibank Berhad"),
      BankModel(id: 23, name: "Maybank"),
      BankModel(id: 24, name: "MBSB Bank"),
    ]);

    bank.updateInitialValue(initBankModel);

    email.addAsyncValidators(
      [_checkEmail],
    );

    phoneNo.addAsyncValidators(
      [_checkPhoneNo],
    );

    icNo.addAsyncValidators(
      [_checkIcNumber],
    );
  }

  @override
  void onSubmitting() async {
    try {
      print("calling API");
      RegisterClientRequestModel requestModel = RegisterClientRequestModel();

      // Account details
      requestModel.name = name.value.trim();

      requestModel.email = email.value.trim();
      requestModel.password = password.value.trim();
      requestModel.icNo = icNo.value.trim();
      requestModel.phoneNo = phoneNo.value.trim();
      requestModel.genderId = gender.value!.id;
      requestModel.address = address.value;
      requestModel.worldDivisionId = getDivisionValue();
      requestModel.worldCityId = getCityValue();

      print("account details");
      requestModel.profilePhoto = newProfilePhoto!;

      print("user bg");

      // Bank details
      requestModel.bankId = bank.value!.id;
      requestModel.accountNumber = accountNo.value;
      print("bank details");

      print("object");
      // Call API
      DefaultResponseModel responseModel =
          await userBloc.register(requestModel);
      print(responseModel);

      // Handle response
      if (responseModel.isSuccess) {
        print("success register");
        emitSuccess(successResponse: email.value.trim());
      } else {
        emitFailure(failureResponse: responseModel.message);
      }
    } catch (e) {
      emitFailure(failureResponse: e.toString());
      print(e);
    }
  }
}
