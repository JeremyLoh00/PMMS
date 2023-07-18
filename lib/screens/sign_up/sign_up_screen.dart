import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
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

class _SignUpScreenState extends State<SignUpScreen> {
  int activeStepper = 1;
  bool _isLoading = false;
  SingingCharacter? _character = SingingCharacter.male;
  String src =
      "https://c4.wallpaperflare.com/wallpaper/246/739/689/digital-digital-art-artwork-illustration-abstract-hd-wallpaper-preview.jpg";
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [PersonalInformationScreen()]),
        ),
      ),
    );
  }
}
