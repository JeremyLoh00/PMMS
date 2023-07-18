import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/form_bloc/register_client_form_bloc.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/screens/edit_profile/components/change_password_screen.dart';
import 'package:private_nurse_for_client/screens/edit_profile/components/file_uploader_edit_profile.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/input_decoration.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/screens/sign_up/components/body.dart';
import 'package:private_nurse_for_client/screens/sign_up/components/personal_information_screen.dart';
import 'package:private_nurse_for_client/screens/sign_up/components/email_verification_screen.dart';
import 'package:private_nurse_for_client/theme.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

class SignUpScreen extends StatefulWidget {
  int activeStepper;
  final UserModel? userModel;
  SignUpScreen({
    super.key,
    this.activeStepper = 1,
    this.userModel,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

enum SingingCharacter { male, female }

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _controller;
  RegisterClientFormBloc? formBloc;
  bool _isLoading = false;
  SingingCharacter? _character = SingingCharacter.male;
  String src =
      "https://c4.wallpaperflare.com/wallpaper/246/739/689/digital-digital-art-artwork-illustration-abstract-hd-wallpaper-preview.jpg";

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: const Text("Registration"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        bottomOpacity: 0.0,
      ),
      body: BlocProvider(
        create: (context) => RegisterClientFormBloc(),
        child: Builder(
          builder: (context) {
            final formBloc = BlocProvider.of<RegisterClientFormBloc>(context);

            return FormBlocListener<RegisterClientFormBloc, String, String>(
              // On submit
              onSubmitting: (context, state) {
                // Remove focus from input field
                FocusScope.of(context).unfocus();
                // Set loading true
                setState(() {
                  _isLoading = true;
                });
              },
              onSuccess: (context, state) {
                // Set loading false
                setState(() {
                  // _isLoading = false;
                  // widget.activeStepper = 4;
                });
              },
              // Validation failed
              onSubmissionFailed: (context, state) {
                // Set loading false
                setState(() {
                  _isLoading = false;
                });
              },
              onFailure: (context, state) {
                // Set loading to false
                setState(() {
                  _isLoading = false;
                });

                ThemeSnackBar.showSnackBar(
                    context, state.failureResponse ?? "");
                return;
              },
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Body(
                  activeStepper: widget.activeStepper,
                  callBackSetActiveStepper: (int value) {
                    // Change tab
                    setState(() {
                      widget.activeStepper = value;
                    });
                  },
                  callBackSetIsLoading: (bool value) {
                    // Change loading state
                    setState(() {
                      _isLoading = value;
                    });
                  },
                  formBloc: formBloc,
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: widget.activeStepper != 2
          ? Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    child: ButtonPrimary(
                      getButtonText(),
                      onPressed: () {
                        handleButtonOnPressed.call();
                      },
                      isLoading: _isLoading,
                      loadingText: getLoadingText(),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  getLoadingText() {
    if (widget.activeStepper == 3) {
      return "Registering...";
    }
    return "";
  }

  handleButtonOnPressed() async {
    if (widget.activeStepper == 1) {
      // validate all inputs here
      if (await formBloc!.name.validate() &&
          await formBloc!.email.validate() &&
          await formBloc!.password.validate() &&
          await formBloc!.icNo.validate() &&
          await formBloc!.phoneNo.validate()) {
        setState(() {
          widget.activeStepper = 2;
        });
      }
    } else if (widget.activeStepper == 2) {
      setState(() {
        // formBloc!.submit();
        widget.activeStepper = 2;
        print("email verify");
      });

      print(formBloc!.toString());
      return formBloc!.submit();
    }
  }

  String getButtonText() {
    if (widget.activeStepper == 1) {
      return "Next";
    } else if (widget.activeStepper == 2) {
      return "Register";
    }
    return "";
  }
}
