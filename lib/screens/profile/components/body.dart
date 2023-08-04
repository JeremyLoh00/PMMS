import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/bloc/user_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/theme.dart';

class Body extends StatefulWidget {
  final UserModel? userModel;
  const Body({super.key, this.userModel});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserBloc userBloc = UserBloc();
  @override
  void initState() {
    super.initState();
    print(widget.userModel!.profilePhoto!);
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            profilePic(),
            Space(20),
            Text(
              widget.userModel!.name!.toUpperCase(),
              style: const TextStyle(
                color: kSecondaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Space(10),
            Text(
              widget.userModel!.email!.toLowerCase(),
              style: const TextStyle(
                color: kBlack,
                fontSize: 14,
              ),
            ),
            Space(10),
            Text(
              widget.userModel!.phoneNo!.toLowerCase(),
              style: const TextStyle(
                color: kDarkGrey,
                fontSize: 14,
              ),
            ),
            Space(20),
            profileInformation(
              title: "Address",
              icon: Iconsax.home,
              sub: widget.userModel!.address!,
            ),
            profileInformation(
              title: "Bank Information",
              icon: Iconsax.bank,
              sub: widget.userModel!.bankModel!.name!,
              description: widget.userModel!.accountNumber!,
            ),
          ],
        ),
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
          imageUrl: widget.userModel!.profilePhoto!,
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
}
