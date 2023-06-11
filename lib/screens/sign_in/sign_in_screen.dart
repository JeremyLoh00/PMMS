import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/screens/forgot_password/forgot_password_screen.dart';
import 'package:private_nurse_for_client/screens/navigation/navigation.dart';
import 'package:private_nurse_for_client/screens/sign_up/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  // static const routeName = '/sign-in-screen';
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: loginForm(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginForm(BuildContext context) {
    return Column(
      children: [
        TextField(
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
        const SizedBox(
          height: 10,
        ),
        //Password
        TextField(
          cursorColor: kPrimaryColor,
          textCapitalization: TextCapitalization.none,
          inputFormatters: [
            LowerCaseTextFormatter(),
          ],
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Enter your password",
            prefixIcon: const Icon(
             Iconsax.unlock,
              color: kPrimaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        ScaleTap(
          onPressed: () {
            navigateTo(context, ForgotPasswordScreen());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Forgot Password?",
                style: TextStyle(color: kPrimaryColor),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
        ),
        //Button Login
        // ButtonPrimary(
        //   "Login",
        //   onPressed: formBloc.submit,
        //   isLoading: _isLoading,
        //   loadingText: "Signing you in...",
        // ),

        ButtonPrimary(
          "Login",
          onPressed: () {
            navigateTo(context, Navigation());
          },
          isLoading: _isLoading,
          loadingText: "Signing you in...",
        ),

        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            // Navigator.push(context, route)
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?"),
              SizedBox(width: 0),
              GestureDetector(
                  onTap: () {
                    navigateTo(context, SignUpScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 20, top: 20, bottom: 20),
                    child: RichText(
                      text: const TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
