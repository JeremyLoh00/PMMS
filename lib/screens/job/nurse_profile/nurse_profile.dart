import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/public_components/button_primary.dart';
import 'package:private_nurse_for_client/public_components/button_secondary.dart';
import 'package:private_nurse_for_client/public_components/delete_dialog.dart';
import 'package:private_nurse_for_client/screens/job/nurse_profile/components/nurse_profile_review.dart';
import 'package:private_nurse_for_client/screens/job/nurse_profile/components/nurse_profile_header.dart';
import 'package:private_nurse_for_client/theme.dart';

class NurseProfile extends StatefulWidget {
  final String src;
  final bool? hasButton;
  const NurseProfile({super.key, required this.src, this.hasButton = false});

  @override
  State<NurseProfile> createState() => _NurseProfileState();
}

final String commentPic =
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg";

class _NurseProfileState extends State<NurseProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      drawerEnableOpenDragGesture: true,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
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
                        imageUrl: widget.src,
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
                  title: "Nurse Aida",
                  totalReview: "4.0 (200 Reviews)",
                  phoneNum: "012-3456789",
                  education: "Bachelor Degree in Nursing",
                  location: "Malaysia Nursing College",
                  experience: "Sri Kota Hospital",
                  time: "5 years",
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
                NurseProfileReview(
                  src: widget.src,
                  description: "Hello",
                  name: "C***t",
                  comment: "Good attitude but careless.",
                  commentPic: commentPic,
                  date: "21-5-2023 | 5.45 pm",
                ),
                SizedBox(
                  height: 10,
                ),
                widget.hasButton == true
                    ? Row(
                        children: [
                          Expanded(
                            child: ButtonSecondary(
                              paddingVertical: 17,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              text: "Reject",
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ButtonPrimary(
                              "Accept",
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: kWhite,
                                  content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: kBgDanger,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: const Icon(
                                            Icons.warning_amber,
                                            color: Colors.red,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Subscription Not Complete",
                                          style: textStyleH1(),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Subscription is not complete yet, please subscribe before accepting any nurse.",
                                          textAlign: TextAlign.center,
                                          style:
                                              textStyleNormal(color: kTextGray),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: ButtonPrimary(
                                                "Pay",
                                                onPressed: () {},
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: ButtonSecondary(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                text: "Cancel",
                                              ),
                                            ),
                                          ],
                                        )
                                      ]),
                                ),
                              ),
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
      title: Text(
        "Profile",
        style: TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.bold,
        ),
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
