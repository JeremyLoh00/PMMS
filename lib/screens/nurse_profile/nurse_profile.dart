import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/bloc/job_bloc.dart';
import 'package:private_nurse_for_client/bloc/nurse_bloc.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/list_of_applied_nurse/list_of_applied_nurse_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/button_secondary.dart';
import 'package:private_nurse_for_client/public_components/custom_dialog.dart';
import 'package:private_nurse_for_client/public_components/theme_snack_bar.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/nurse_profile_header.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/nurse_profile_review.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/reject_reason.dart';
import 'package:private_nurse_for_client/theme.dart';

class NurseProfile extends StatefulWidget {
  final bool? hasButton;
  final ListOfAppliedNurseModel lsitOfAppliedNurseModel;
  final JobModel jobModel;
  const NurseProfile(
      {super.key,
      required this.lsitOfAppliedNurseModel,
      required this.jobModel,
      this.hasButton = false});

  @override
  State<NurseProfile> createState() => _NurseProfileState();
}

final String commentPic =
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg";
final int subCode = 200;
bool block = false;

class _NurseProfileState extends State<NurseProfile> {
  bool _isLoadingAccept = false;
  bool _isLoadingReject = false;
  bool _isLoading = false;
  JobsBloc jobsBloc = JobsBloc();
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
                  child: Hero(
                    tag: "contest-banner",
                    // child: Text("data"),
                    child: Container(
                      child: CachedNetworkImage(
                        imageUrl: widget.lsitOfAppliedNurseModel.profilePhoto!,
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
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                NurseProfileHeader(
                  title: widget.lsitOfAppliedNurseModel.name!,
                  totalReview:
                      widget.lsitOfAppliedNurseModel.nurse!.averageRating!,
                  phoneNum: widget.lsitOfAppliedNurseModel.phoneNo!,
                  education:
                      widget.lsitOfAppliedNurseModel.nurse!.educationLevel!,
                  location: widget.lsitOfAppliedNurseModel.nurse!.collegeName!,
                  experience:
                      widget.lsitOfAppliedNurseModel.nurse!.workExperience!,
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 0.5,
                  color: kGrey,
                ),
                SizedBox(
                  height: 10,
                ),
                NurseProfileReview(),
                SizedBox(
                  height: 10,
                ),
                widget.hasButton == true
                    ? Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ButtonSecondary(
                              paddingVertical: 17,
                              onPressed: () {
                                navigateTo(context, RejectReason());
                              },
                              text: "Reject",
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: ButtonPrimary(
                              "Hire Me",
                              onPressed: () => (subCode == 200
                                  ? showHireNursePopup(context)
                                  : showSubscriptionPopup(
                                      context)), //Confirmation of hire OR subscription if not subscribe yet

                              // showDialog(
                              //   context: context,
                              //   builder: (context) => AlertDialog(
                              //     backgroundColor: kWhite,
                              //     content: Column(
                              //         mainAxisSize: MainAxisSize.min,
                              //         children: [
                              //           Container(
                              //             padding: const EdgeInsets.all(10),
                              //             decoration: BoxDecoration(
                              //                 color: kBgDanger,
                              //                 borderRadius:
                              //                     BorderRadius.circular(50)),
                              //             child: const Icon(
                              //               Icons.warning_amber,
                              //               color: Colors.red,
                              //             ),
                              //           ),
                              //           const SizedBox(
                              //             height: 10,
                              //           ),
                              //           Text(
                              //             "Subscription Not Complete",
                              //             style: textStyleH1(),
                              //           ),
                              //           const SizedBox(
                              //             height: 10,
                              //           ),
                              //           Text(
                              //             "Subscription is not complete yet, please subscribe before accepting any nurse.",
                              //             textAlign: TextAlign.center,
                              //             style:
                              //                 textStyleNormal(color: kTextGray),
                              //           ),
                              //           const SizedBox(
                              //             height: 10,
                              //           ),
                              //           Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceBetween,
                              //             children: [
                              //               Expanded(
                              //                 child: Container(
                              //                   height: 52,
                              //                   margin: EdgeInsets.all(10),
                              //                   child: ButtonPrimary(
                              //                     "Pay",
                              //                     onPressed: () {},
                              //                   ),
                              //                 ),
                              //               ),
                              //               const SizedBox(
                              //                 height: 10,
                              //               ),
                              //               Expanded(
                              //                 child: ButtonSecondary(
                              //                   onPressed: () {
                              //                     Navigator.pop(context);
                              //                   },
                              //                   text: "Cancel",
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ]),
                              //   ),
                              // ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
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
            onPressed: () => (block == true
                ? showUnblockNursePopup(context)
                : showBlockNursePopup(context)),
            child: Text(
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
  } // Popup if user want to hire nurse

  Future<bool> showHireNursePopup(BuildContext context) async {
    // If cant pop then show this dialog
    // Unfocus from input field
    FocusScope.of(context).unfocus();
    // Show dialog
    return await CustomDialog.show(
          context,
          title: "Hire Confirmation",
          description:
              "Are you sure to hire this nurse for this job? Retrieve action is not available after accepting the application.",
          btnCancelText: "Cancel",
          btnOkText: "Hire",
          btnCancelOnPress: () => Navigator.of(context).pop(),
          btnOkOnPress: () => hireNurse(),
          icon: Iconsax.info_circle,
          // dialogType: DialogType.warning,
        ) ??
        // If show dialog return null, return false
        false;
  }

  Future<void> hireNurse() async {
    setState(() {
      _isLoadingAccept = true;
    });
    DefaultResponseModel responseModel =
        await jobsBloc.acceptJob(widget.jobModel.id!);

    setState(() {
      _isLoadingAccept = false;
    });
    if (responseModel.isSuccess) {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
      }
    } else {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
      }
    }
  }

  // Popup if user want to block nurse
  Future<bool> showBlockNursePopup(BuildContext context) async {
    // If cant pop then show this dialog
    // Unfocus from input field
    FocusScope.of(context).unfocus();
    // Show dialog
    return await CustomDialog.show(
          context,
          title: "Block Nurse",
          description:
              "Are you sure to block the nurse? You can unblock the nurse at the “Blocked Nurse” list. ",
          btnCancelText: "Cancel",
          btnOkText: "Block",
          btnCancelOnPress: () => Navigator.of(context).pop(),
          btnOkOnPress: () => {blockNurse(), Navigator.of(context).pop(true)},
          icon: Iconsax.info_circle,
          // dialogType: DialogType.warning,
        ) ??
        // If show dialog return null, return false
        false;
  }

// Popup if user want to unblock nurse
  Future<bool> showUnblockNursePopup(BuildContext context) async {
    // If cant pop then show this dialog
    // Unfocus from input field
    FocusScope.of(context).unfocus();
    // Show dialog
    return await CustomDialog.show(
          context,
          title: "Unblock Nurse",
          description: "Are you sure to unblock the nurse?",
          btnCancelText: "Cancel",
          btnOkText: "Unblock",
          btnCancelOnPress: () => Navigator.of(context).pop(),
          btnOkOnPress: () => {Navigator.of(context).pop(true)},
          icon: Iconsax.info_circle,
          // dialogType: DialogType.warning,
        ) ??
        // If show dialog return null, return false
        false;
  }

  Future<void> blockNurse() async {
    setState(() {
      _isLoadingAccept = true;
    });
    DefaultResponseModel responseModel =
        await nurseBloc.blockNurse(widget.lsitOfAppliedNurseModel.nurse!.id!);

    setState(() {
      _isLoadingAccept = false;
    });
    if (responseModel.isSuccess) {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
      }
    } else {
      if (mounted) {
        ThemeSnackBar.showSnackBar(context, responseModel.message);
      }
    }
  }
}
