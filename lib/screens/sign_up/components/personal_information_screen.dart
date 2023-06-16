import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/screens/edit_profile/edit_profile_screen.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/input_decoration.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/sign_up/components/body.dart';
import 'package:private_nurse_for_client/screens/sign_up/components/email_verification_screen.dart';
import 'package:private_nurse_for_client/theme.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  SingingCharacter? _character = SingingCharacter.male;
  String? selectedValue;
  String src =
      "https://c4.wallpaperflare.com/wallpaper/246/739/689/digital-digital-art-artwork-illustration-abstract-hd-wallpaper-preview.jpg";
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Body(activeStepper: 1,),
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
          decoration: textFieldInputDecoration(
            "Name",
            hintText: "ex: Rolex Dilly",
            prefixIcon: Icon(
              Iconsax.profile_circle,
              color: kPrimaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          keyboardType: TextInputType.name,
          cursorColor: kPrimaryColor,
          decoration: textFieldInputDecoration(
            "Email",
            hintText: "ex: something@nurse.com",
            prefixIcon: const Icon(
              Iconsax.sms,
              color: kPrimaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          keyboardType: TextInputType.name,
          cursorColor: kPrimaryColor,
          decoration: textFieldInputDecoration(
            "IC / Passport Number",
            hintText: "ex:0000000000",
            prefixIcon: const Icon(
              Iconsax.personalcard,
              color: kPrimaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          keyboardType: TextInputType.name,
          cursorColor: kPrimaryColor,
          decoration: textFieldInputDecoration(
            "Phone Number",
            hintText: "ex:0123456789",
            prefixIcon: const Icon(
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
          decoration: textFieldInputDecoration(
            "Address",
            hintText: "Address",
            prefixIcon: Icon(
              Iconsax.home,
              color: kPrimaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: ScaleTap(
                onPressed: () {},
                child: DropdownButtonFormField2<String>(
                  decoration: textFieldInputDecoration2(),
                  isExpanded: true,
                  enableFeedback: true,
                  hint: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'City',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    //swidth: double.infinity,
                    padding: null,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [profileShadow(kGrey.withOpacity(0.3))],
                      color: kWhite,
                    ),
                    elevation: 0,
                    offset: const Offset(0, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(2),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 3,
              child: ScaleTap(
                onPressed: () {},
                child: DropdownButtonFormField2<String>(
                  decoration: textFieldInputDecoration2(),
                  isExpanded: true,
                  enableFeedback: true,
                  hint: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'State',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    //swidth: double.infinity,
                    padding: null,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [profileShadow(kGrey.withOpacity(0.3))],
                      color: kWhite,
                    ),
                    elevation: 0,
                    offset: const Offset(0, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(2),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                    });
                  },
                ),
              ),
            ),
          ],
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
          decoration: textFieldInputDecoration(
            "Bank",
            hintText: "Public Bank",
            prefixIcon: Icon(
              Iconsax.bank,
              color: kPrimaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          keyboardType: TextInputType.name,
          cursorColor: kPrimaryColor,
          decoration: textFieldInputDecoration(
            "Account",
            hintText: "631520200",
            prefixIcon: Icon(
              Iconsax.card,
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
      ],
    );
  }
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
  String src =
      "https://c4.wallpaperflare.com/wallpaper/246/739/689/digital-digital-art-artwork-illustration-abstract-hd-wallpaper-preview.jpg";
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
