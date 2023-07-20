import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:private_nurse_for_client/bloc/change_password_bloc.dart';
import 'package:private_nurse_for_client/helpers/validators.dart';
import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/password/change_password_model.dart';
import 'package:private_nurse_for_client/models/user/validate_password_response_model.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';

class ChangePasswordFormBloc
    extends FormBloc<String, ValidatePasswordErrorsModel> {
  ChangePasswordBloc changePassword = ChangePasswordBloc();

  final BuildContext context;
 

  final newPassword = TextFieldBloc(
    validators: [
      InputValidator.required,
      InputValidator.passwordChar,
    ],
  );

  final confirmPassword = TextFieldBloc(
    validators: [InputValidator.required],
  );

  final currentPassword = TextFieldBloc(
    validators: [InputValidator.required],
  );

  Validator<String> _confirmPassword(
    TextFieldBloc newPasswordTextFieldBloc,
  ) {
    return (String confirmPassword) {
      if (confirmPassword == newPasswordTextFieldBloc.value) {
        return null;
      }
      return "Your password do not match";
    };
  }

  ChangePasswordFormBloc(this.context ) {
    addFieldBlocs(fieldBlocs: [
      newPassword,
      confirmPassword,
      currentPassword,
    ]);

    confirmPassword
      ..addValidators([_confirmPassword(newPassword)])
      ..subscribeToFieldBlocs([newPassword]);
  }

  @override
  Future<void> onSubmitting() async {
    try {
      ChangePasswordRequestModel requestModel = ChangePasswordRequestModel();
      requestModel.password = newPassword.value;
      requestModel.passwordConfirmation = confirmPassword.value;
      requestModel.currentPassword = currentPassword.value;

      DefaultResponseModel responseModel =
          await changePassword.updatePassword(requestModel);

      if (responseModel.isSuccess) {
        emitSuccess(successResponse: responseModel.data);
        print(responseModel.message);

       
      } else {
        emitFailure(failureResponse: responseModel.errors);
        print(responseModel.message);
        ThemeSnackBar.showSnackBar(context, responseModel.message);
      }
    } catch (e) {
      emitFailure(failureResponse: null);
    }
  }
}
