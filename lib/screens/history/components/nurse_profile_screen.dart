import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';

import 'package:private_nurse_for_client/bloc/nurse_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/models/default_response_model.dart';

import 'package:private_nurse_for_client/models/user/user_model.dart';
import 'package:private_nurse_for_client/public_components/custom_dialog.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';

import 'package:private_nurse_for_client/screens/nurse_profile/components/nurse_profile_header.dart';

class NurseProfileScreen extends StatefulWidget {
  final UserModel userModel;
  final Function() callbackRefresh;
  const NurseProfileScreen({
    super.key,
    required this.userModel,
    required this.callbackRefresh,
  });

  @override
  State<NurseProfileScreen> createState() => _NurseProfileScreenState();
}

bool block = false;

class _NurseProfileScreenState extends State<NurseProfileScreen> {
  NurseBloc nurseBloc = NurseBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      drawerEnableOpenDragGesture: true,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: widget.userModel.profilePhoto!,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                NurseProfileHeader(
                  title: widget.userModel.name!,
                  totalReview: widget.userModel.nurseModel!.averageRating!,
                  phoneNum: widget.userModel.phoneNo!,
                  education: widget.userModel.nurseModel!.educationLevel!,
                  location: widget.userModel.nurseModel!.collegeName!,
                  experience: widget.userModel.nurseModel!.workExperience!,
                  nurseId: widget.userModel.nurseModel!.id!,
                ),
                SizedBox(
                  height: 10,
                ),
                // Divider(
                //   thickness: 0.5,
                //   color: kGrey,
                // ),
                SizedBox(
                  height: 10,
                ),
                // NurseProfileReview(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Nurse Profile",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              color: kBlack,
            ),
          ),
          ScaleTap(
            onPressed: () {
              showPopupWarning();
            },
            child: const Text(
              "Block Nurse",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                color: kDanger,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void showPopupWarning() {
    CustomDialog.show(
      context,
      icon: Iconsax.info_circle,
      title: "Block Nurse",
      description:
          "Are you sure to block the nurse? You can unblock the nurse at the “Blocked Nurse” list. ",
      btnCancelText: "Cancel",
      btnOkText: "Block",
      btnCancelOnPress: () => Navigator.of(context).pop(),
      btnOkOnPress: () async {
        Navigator.pop(context);
        await blockNurse();
      },

      // dialogType: DialogType.warning,
    );
  }

  Future<void> blockNurse() async {
    CustomDialog.show(
      context,
      isDissmissable: false,
      title: "Blocking Nurse...",
      center: ThemeSpinner.spinner(),
    );
    DefaultResponseModel responseModel =
        await nurseBloc.blockNurse(widget.userModel.nurseModel!.id!);
    Navigator.pop(context);

    if (responseModel.isSuccess) {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
        Navigator.of(context).pop();
        widget.callbackRefresh();
      }
    } else {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
      }
    }
  } // Popup if user want to hire nurse
}
