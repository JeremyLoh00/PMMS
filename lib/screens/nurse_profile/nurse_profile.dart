import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/list_of_applied_nurse/list_of_applied_nurse_model.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/button_secondary.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/nurse_profile_header.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/nurse_profile_review.dart';
import 'package:private_nurse_for_client/screens/nurse_profile/components/reject_reason.dart';
import 'package:private_nurse_for_client/theme.dart';

class NurseProfile extends StatefulWidget {
  final bool? hasButton;
  final ListOfAppliedNurseModel lsitOfAppliedNurseModel;
  const NurseProfile(
      {super.key,
      required this.lsitOfAppliedNurseModel,
      this.hasButton = false});

  @override
  State<NurseProfile> createState() => _NurseProfileState();
}

final String commentPic =
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg";
final int subCode = 200;
bool block = false;

class _NurseProfileState extends State<NurseProfile> {
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
                height: 800,
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
                    Expanded(child: NurseProfileReview()),
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
  }
}
