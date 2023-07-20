import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/bloc/forgot_password_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/h1.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/screens/forgot_password/forgot_password2_screen.dart';
import 'package:private_nurse_for_client/screens/forgot_password/forgot_password3_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool isEmailRegistered = true;
  TextEditingController emailEditingController = new TextEditingController();
  final ForgotPasswordBloc forgotPassword = ForgotPasswordBloc();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //callback function when back button is pressed
        return showCancelForgotPasswordPopup(context);
      },
      child: Scaffold(
        backgroundColor: kWhite,
        key: scaffoldKey,
        appBar: ThemeAppBar(
          "Reset Password",
          onBackPressed: () async {
            //callback function when back button is pressed
            if (await showCancelForgotPasswordPopup(context)) {
              Navigator.of(context).pop();
            }
          },
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(),
                    child: Center(
                      child: Icon(
                        Iconsax.security_safe,
                        size: 70,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  Space(20),
                  H1(title: "Forgot Password?"),
                  Space(20),
                  Text(
                    "Don't worry, we will send you OTP PIN to your registered email address to reset your password.",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailEditingController,
                          cursorColor: kPrimaryColor,
                          textCapitalization: TextCapitalization.none,
                          inputFormatters: [
                            LowerCaseTextFormatter(),
                          ],
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "ex: example@aufmbz.com",
                            prefixIcon: const Icon(
                              Iconsax.sms,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),

                        ButtonPrimary(
                          "Send Code",
                          loadingText: "Checking email...",
                          isLoading: isLoading,
                          onPressed: () async {
                            setState(() {
                              isEmailRegistered = true;
                              isLoading = true;
                            });

                            //call api to verify email either exist or not
                            DefaultResponseModel responseModel =
                                await forgotPassword
                                    .verifyEmail(emailEditingController.text);

                            setState(() {
                              isLoading = false;
                            });

                            if (responseModel.isSuccess) {
                               Navigator.pop(context);
                              // Navigate to forgot password 2 screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPassword2Screen(
                                      email: emailEditingController.text),
                                ),
                              );
                            } else {
                              ThemeSnackBar.showSnackBar(
                                  context, responseModel.message);

                              setState(() {
                                isEmailRegistered = false;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
