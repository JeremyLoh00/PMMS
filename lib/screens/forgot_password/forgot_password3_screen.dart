import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/bloc/forgot_password_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/forgot_password_form_bloc.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/models/user/validate_password_response_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/custom_dialog.dart';
import 'package:private_nurse_for_client/public_components/input_decoration%20copy.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/screens/sign_in/sign_in_screen.dart';

class ForgotPassword3Screen extends StatefulWidget {
  final String email;
  final String otp;
  const ForgotPassword3Screen({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<ForgotPassword3Screen> createState() => _ForgotPassword3ScreenState();
}

class _ForgotPassword3ScreenState extends State<ForgotPassword3Screen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //callback function when back button is pressed
        return showCancelForgotPasswordPopup(context);
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocProvider(
          create: (BuildContext context) =>
              ForgotPasswordFormBloc(widget.email, widget.otp),
          child: Builder(
            builder: (context) {
              final ForgotPasswordFormBloc formBloc =
                  BlocProvider.of<ForgotPasswordFormBloc>(context);

              return Scaffold(
                appBar: ThemeAppBar(
                  "Reset Password",
                  onBackPressed: () async {
                    //callback function when back button is pressed
                    if (await showCancelForgotPasswordPopup(context)) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
                bottomNavigationBar: // Button Continue
                    Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                  // Button will only not available if at verify email step
                  child: ButtonPrimary(
                    "Change Password",
                    onPressed: formBloc.submit,
                  ),
                ),
                body: Body(
                  formBloc: formBloc,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  final ForgotPasswordFormBloc formBloc;
  Body({
    super.key,
    required this.formBloc,
  });

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return FormBlocListener<ForgotPasswordFormBloc, String,
        ValidatePasswordErrorsModel>(
      onSubmitting: (context, state) {
        FocusScope.of(context).unfocus();
        CustomDialog.show(context,
            description: "Changing your password...",
            isDissmissable: false,
            center: Center(
              child: ThemeSpinner.spinner(),
            ));
      },
      onSuccess: (context, state) {
        Navigator.pop(context);
        CustomDialog.show(context,
            title: "Password Change",
            icon: Iconsax.info_circle,
            isDissmissable: false,
            description: "Password has been successfully reset.",
            btnOkText: "Okay", btnOkOnPress: () {
          // Navigate to Sign In Screen
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignInScreen()),
              (Route<dynamic> route) => false);
        });
      },
      onFailure: (context, state) {
        Navigator.pop(context);
        if (state.failureResponse != null) {
          // widget.formBloc.currentPassword.addFieldError(state.failureResponse.currentPassword.first);
        } else {
          ThemeSnackBar.showSnackBar(
              context, state.failureResponse!.currentPassword!.first);
        }
      },
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              TextFieldBlocBuilder(
                textFieldBloc: widget.formBloc.newPassword,
                suffixButton: SuffixButton.obscureText,
                obscureTextTrueIcon: Icon(Iconsax.eye_slash),
                obscureTextFalseIcon: Icon(Iconsax.eye),
                cursorColor: kPrimaryColor,
                decoration: textFieldInputDecoration(
                  "New Password",
                  hintText: "Enter your password",
                  prefixIcon: const Icon(
                    Iconsax.lock,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              Space(10),
              TextFieldBlocBuilder(
                textFieldBloc: widget.formBloc.confirmPassword,
                suffixButton: SuffixButton.obscureText,
                obscureTextTrueIcon: Icon(Iconsax.eye_slash),
                obscureTextFalseIcon: Icon(Iconsax.eye),
                cursorColor: kPrimaryColor,
                decoration: textFieldInputDecoration(
                  "Confirm Password",
                  hintText: "Re-enter your password",
                  prefixIcon: const Icon(
                    Iconsax.lock_1,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
