import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_app_bar.dart';
import 'package:private_nurse_for_client/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String src =
      "https://c4.wallpaperflare.com/wallpaper/246/739/689/digital-digital-art-artwork-illustration-abstract-hd-wallpaper-preview.jpg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: ThemeAppBar(
        "Profile",
        trailing: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: ScaleTap(
            onPressed: () {
              // navigateTo(
              //     context,
              //     EditProfileScreen(
              //       userModel: _userModel,
              //     ));
            },
            child: const Icon(
              Iconsax.edit,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              verifiedRow(),
              profilePic(),
              Space(20),
              Text(
                "Your Name".toUpperCase(),
                style: const TextStyle(
                  color: kSecondaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Space(10),
              Text(
                "youremail@gmail.com".toLowerCase(),
                style: const TextStyle(
                  color: kBlack,
                  fontSize: 14,
                ),
              ),
              Space(10),
              Text(
                "0132949292".toLowerCase(),
                style: const TextStyle(
                  color: kDarkGrey,
                  fontSize: 14,
                ),
              ),
              Space(20),
              profileInformation(
                title: "Address",
                icon: Iconsax.home,
                sub: "123, Jalan Peramu Permai",
              ),
              profileInformation(
                title: "Education",
                icon: Icons.school,
                sub: "Malaysia Nursing College",
                description: "Degree in Nursing",
              ),
              profileInformation(
                title: "Working",
                icon: Icons.business_center,
                sub: "Sri Kota Hospital",
                description: "5 years",
              ),
              profileInformation(
                title: "Bank Information",
                icon: Iconsax.bank,
                sub: "Maybank",
                description: "3454623454564",
              ),
              profileInformation(
                title: "Emergency Contact",
                icon: Icons.person,
                sub: "Ali",
                relation: "father",
                description: "012-2343543254",
              ),
            ],
          ),
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

  Row verifiedRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.check,
                color: kWhite,
                size: 18,
              ),
              SizedBox(width: 5),
              Text(
                "Verified",
                style: TextStyle(
                  color: kWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
