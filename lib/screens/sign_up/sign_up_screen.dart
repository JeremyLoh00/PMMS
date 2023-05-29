import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/edit_profile/components/change_password_screen.dart';
import 'package:private_nurse_for_client/edit_profile/components/file_uploader_edit_profile.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/screens/sign_up/email_verification_screen.dart';
import 'package:private_nurse_for_client/theme.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

enum SingingCharacter { male, female }

class _SignUpScreenState extends State<SignUpScreen> {
  SingingCharacter? _character = SingingCharacter.male;
  String src =
      "https://c4.wallpaperflare.com/wallpaper/246/739/689/digital-digital-art-artwork-illustration-abstract-hd-wallpaper-preview.jpg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: ThemeAppBar(
        "Registration",
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            profilePic(),
            Space(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Personal Information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            Space(10),
            TextField(
              keyboardType: TextInputType.name,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                labelText: "Name",
                hintText: "ex: Rolex Dilly",
                prefixIcon: Icon(
                  Iconsax.profile_circle,
                  color: kPrimaryColor,
                ),
              ),
            ),
            TextField(
              keyboardType: TextInputType.name,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "ex: example@example.com",
                prefixIcon: Icon(
                  Iconsax.profile_circle,
                  color: kPrimaryColor,
                ),
              ),
            ),
            TextField(
              keyboardType: TextInputType.name,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                labelText: "IC",
                hintText: "001229-10-3278",
                prefixIcon: Icon(
                  Iconsax.profile_circle,
                  color: kPrimaryColor,
                ),
              ),
            ),
            TextField(
              keyboardType: TextInputType.name,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                labelText: "Phone Number",
                hintText: "ex:0123456789",
                prefixIcon: Icon(
                  Iconsax.call,
                  color: kPrimaryColor,
                ),
              ),
            ),
            Space(20),
            Text(
              "Gender",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Space(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Male'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.male,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Female'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.female,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Space(20),
            Text(
              "Address",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Space(10),
            TextField(
              keyboardType: TextInputType.name,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                labelText: "Address",
                hintText: "Home",
                prefixIcon: Icon(
                  Iconsax.home,
                  color: kPrimaryColor,
                ),
              ),
            ),
            Space(20),
            Text(
              "Bank Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Space(10),
            TextField(
              keyboardType: TextInputType.name,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                labelText: "Bank",
                hintText: "Public Bank",
                prefixIcon: Icon(
                  Iconsax.profile_circle,
                  color: kPrimaryColor,
                ),
              ),
            ),
            TextField(
              keyboardType: TextInputType.name,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                labelText: "Account",
                hintText: "631520200",
                prefixIcon: Icon(
                  Iconsax.profile_circle,
                  color: kPrimaryColor,
                ),
              ),
            ),
            Space(20),
            ButtonPrimary("Next", onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EmailVerificationScreen(email: "izzatnick123@gmail.com"),
                ),
              );
            })
          ]),
        ),
      ),
    );
  }

  Widget profileInformation(
      {required String title,
      required IconData icon,
      required String sub,
      String? relation,
      String? description}) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: kPrimary100Color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            profileShadow(kPrimary100Color),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Space(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 5),
              Icon(
                icon,
                size: 20,
                color: kPrimaryColor,
              ),
              SizedBox(width: 15),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      relation != null ? "$sub ($relation)" : sub,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    Space(3),
                    description != null
                        ? Text(
                            description,
                            style: TextStyle(
                              color: kGrey,
                              fontSize: 12,
                            ),
                          )
                        : Space(0),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget profilePic() {
    return Hero(
      tag: 'editprofile',
      child: Container(
        width: 100,
        height: 100,
        padding: EdgeInsets.all(0.5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: kPrimaryColor),
        ),
        child: CachedNetworkImage(
          imageUrl: src,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => const CircularProgressIndicator(
            color: kPrimaryColor,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
