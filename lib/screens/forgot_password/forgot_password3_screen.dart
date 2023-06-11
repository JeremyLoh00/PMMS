import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';

class ForgotPassword3Screen extends StatefulWidget {
  final String email;
  // final String otp;
  const ForgotPassword3Screen(
      {super.key, required this.email, });
      // required this.otp

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
            child: Scaffold(
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
                    onPressed: () => (),
                  ),
                ),
                body: Body())));
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "New Password",
                hintText: "Enter your password",
                prefixIcon: const Icon(
                  Iconsax.lock,
                  color: kPrimaryColor,
                ),
              ),
            ),
            Space(10),
            TextField(
              decoration: InputDecoration(
                labelText: "Confirm Password",
                hintText: "Re-enter your password",
                prefixIcon: const Icon(
                  Iconsax.lock,
                  color: kPrimaryColor,
                ),
              ),
            ),
            // TextFieldBlocBuilder(
            //   textFieldBloc: widget.formBloc.confirmPassword,
            //   suffixButton: SuffixButton.obscureText,
            //   obscureTextTrueIcon: Icon(Iconsax.eye_slash),
            //   obscureTextFalseIcon: Icon(Iconsax.eye),
            //   cursorColor: kPrimaryColor,
            //   decoration: textFieldInputDecoration(
            //     "Confirm Password",
            //     hintText: "Re-enter your password",
            //     prefixIcon: const Icon(
            //       Iconsax.lock_1,
            //       color: kPrimaryColor,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
