import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:private_nurse_for_client/bloc/user_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/public_components/h1.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/screens/sign_up/components/body.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final int activeStepper;
  final UserModel userModel;
  final ValueSetter<int> callBackSetActiveStepper;
  EmailVerificationScreen({
    super.key,
    required this.email,
    required this.activeStepper,
    required this.callBackSetActiveStepper,
    required this.userModel,
  });

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  int delayAnimationDuration = 200;
  final UserBloc userBloc = new UserBloc();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  bool isLoading = false;
  bool hasError = false;
  String loadingText = "";

    @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //callback function when back button is pressed
        return showCancelRegistrationPopup(context);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(),
                  child: Center(
                    child: Icon(
                      Iconsax.security_safe,
                      color: kTextSuccess,
                      size: 70,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                H1(title: "OTP Verification"),
                Column(
                  children: [
                    SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "OTP has been sent to ",
                          style: TextStyle(color: kTextGray),
                          children: [
                            TextSpan(
                              text: secureEmail(),
                              //recognizer: onTapRecognizer,
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ]),
                    ),
                    Space(30),
                  ],
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: delayAnimationDuration),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscureText: false,
                    obscuringCharacter: '*',
                    animationType: AnimationType.scale,
                    validator: (v) {
                      if (!RegExp(r'^[0-9]+$').hasMatch(v?.trim() ?? "")) {
                        return "Invalid OTP";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      borderWidth: 1,
                      fieldHeight: 60,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: kDisabledText,
                      selectedFillColor: Colors.white,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    textStyle: TextStyle(fontSize: 20, height: 1.6),
                    backgroundColor: Colors.white,
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    keyboardType: TextInputType.number,
                    onCompleted: (otp) => processOTP(otp),
                    onChanged: (String value) {},
                  ),
                )
              ],
            ),
          ),
          DelayedDisplay(
              delay: Duration(milliseconds: delayAnimationDuration),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    "Didn't receive an OTP?",
                    style: TextStyle(
                        color: kGrey.shade500,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins"),
                    maxFontSize: 14,
                    minFontSize: 12,
                    maxLines: 1,
                  ),
                  TextButton(
                    onPressed: () {
                      processResend();
                    },
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStatePropertyAll<Color>(kGrey.shade300)),
                    child: const AutoSizeText(
                      "RESEND",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins"),
                      maxFontSize: 14,
                      minFontSize: 12,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
            ),
          isLoading
              ? Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ThemeSpinner.spinner(),
                        SizedBox(height: 15),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: loadingText,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  String secureEmail() {
    // half left
    int middle = (widget.email.length / 2).ceil();
    int midHalf = (middle / 2).ceil();
    int start = midHalf;
    //half right
    int end = middle + midHalf;
    int space = end - start;

    String secure = widget.email.replaceRange(start, end, "*" * space);

    return secure;
  }
  
  void processOTP(String otp) async {
    // TODO: panggil API
    // Check is it number or not
    if (!RegExp(r'^[0-9]+$').hasMatch(otp)) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    } else {
      setState(() {
        loadingText = " Verifying...";
        isLoading = true;
        hasError = false;
      });
      // Call API
      DefaultResponseModel responseModel =
          await userBloc.verifyEmail(widget.userModel.email!, otp);
      if (responseModel.isSuccess) {
        //Successfully verified
        if (mounted) {
          ThemeSnackBar.showSnackBar(
              context, "Thank you! Your email has been verified.");

          Navigator.of(context).pop();
        }
      } else {
        //Failed to verified
        setState(() {
          isLoading = false;
          hasError = true;
        });
        //set error
        errorController.add(ErrorAnimationType.shake);
      }
    }
  }
  
  void processResend() async {
    setState(() {
      loadingText = " Resending code to your email...";
      isLoading = true;
    });
    // Call API
    DefaultResponseModel responseModel =
        await userBloc.resendEmail(widget.userModel.email!);

    setState(() {
      isLoading = false;
    });

    if (responseModel.isSuccess) {
      //Successfully get response from API
      ThemeSnackBar.showSnackBar(
          context,
          responseModel.message == ""
              ? "Failed to fetch data from server, please try again later"
              : responseModel.message);
    }
  }
}
