import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: kWhite,
            appBar: ThemeAppBar("Change Password"),
            body: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Space(10),
                          
                          TextField(
                              // suffixButton: SuffixButton.obscureText,
                              // obscureTextFalseIcon: const Icon(
                              //   Iconsax.eye,
                              //   color: kGrey,
                              // ),
                              // obscureTextTrueIcon: const Icon(
                              //   Iconsax.eye_slash,
                              //   color: kGrey,
                              // ),
                              
                              keyboardType: TextInputType.name,
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                labelText: "Curent Password",
                                hintText: "Enter your current password",
                                prefixIcon: const Icon(
                                  Iconsax.lock,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                    TextField(
                              // suffixButton: SuffixButton.obscureText,
                              // obscureTextFalseIcon: const Icon(
                              //   Iconsax.eye,
                              //   color: kGrey,
                              // ),
                              // obscureTextTrueIcon: const Icon(
                              //   Iconsax.eye_slash,
                              //   color: kGrey,
                              // ),
                              
                              keyboardType: TextInputType.name,
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                labelText: "New Password",
                                hintText: "Enter your new password",
                                prefixIcon: const Icon(
                                  Iconsax.lock,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),TextField(
                              // suffixButton: SuffixButton.obscureText,
                              // obscureTextFalseIcon: const Icon(
                              //   Iconsax.eye,
                              //   color: kGrey,
                              // ),
                              // obscureTextTrueIcon: const Icon(
                              //   Iconsax.eye_slash,
                              //   color: kGrey,
                              // ),
                              
                              keyboardType: TextInputType.name,
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                hintText: "Enter your confirm password",
                                prefixIcon: const Icon(
                                  Iconsax.lock,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          // DelayedDisplay(
                          //   delay:
                          //       Duration(milliseconds: delayAnimationDuration),
                          //   child: TextFieldBlocBuilder(
                          //     suffixButton: SuffixButton.obscureText,
                          //     obscureTextFalseIcon: const Icon(
                          //       Iconsax.eye,
                          //       color: kGrey,
                          //     ),
                          //     obscureTextTrueIcon: const Icon(
                          //       Iconsax.eye_slash,
                          //       color: kGrey,
                          //     ),
                          //     textFieldBloc: formBloc.newPassword,
                          //     keyboardType: TextInputType.name,
                          //     cursorColor: kPrimaryColor,
                          //     decoration: textFieldInputDecoration(
                          //       "New Password",
                          //       hintText: "Enter your new password",
                          //       prefixIcon: const Icon(
                          //         Iconsax.lock,
                          //         color: kPrimaryColor,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // DelayedDisplay(
                          //   delay:
                          //       Duration(milliseconds: delayAnimationDuration),
                          //   child: TextFieldBlocBuilder(
                          //     suffixButton: SuffixButton.obscureText,
                          //     obscureTextFalseIcon: const Icon(
                          //       Iconsax.eye,
                          //       color: kGrey,
                          //     ),
                          //     obscureTextTrueIcon: const Icon(
                          //       Iconsax.eye_slash,
                          //       color: kGrey,
                          //     ),
                          //     textFieldBloc: formBloc.newPassword,
                          //     keyboardType: TextInputType.name,
                          //     cursorColor: kPrimaryColor,
                          //     decoration: textFieldInputDecoration(
                          //       "Confirm Password",
                          //       hintText: "Enter your confirm password",
                          //       prefixIcon: const Icon(
                          //         Iconsax.lock,
                          //         color: kPrimaryColor,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                )),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5
                  ),
                  Expanded(
                    flex: 1,
                    child: ButtonPrimary(
                      "Update", onPressed: () =>(),
                      loadingText: "Updating...",
                      isLoading: _isLoading,
                      //Navigator.pop(context);
                    ),
                  ),
                ],
              ),
            )));
  }
}
