import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/helpers/general_method.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/screens/job/job_detail.dart';
import 'package:private_nurse_for_client/theme.dart';

class NurseHistoryList extends StatefulWidget {
  const NurseHistoryList({
    super.key,
    required this.src,
  });

  final String src;

  @override
  State<NurseHistoryList> createState() => _NurseHistoryListState();
}

class _NurseHistoryListState extends State<NurseHistoryList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 20, // Replace with your actual item count
      itemBuilder: (context, index) {
        return ScaleTap(
          //list onclick
          onPressed: () {
            // navigateTo(context, InformationDetailsScreen(selectedTabIndex: widget.selectedTabIndex,));
            // navigateTo(
            //     context,
            //     JobDetail(
            //       hasComment: false,
            //     ));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  profileShadow(
                    kGrey.withOpacity(0.2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 140,
                        child: CachedNetworkImage(
                          imageUrl: widget.src,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 15),
                  //First row of info include points
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Space(7),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Nurse Aida",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: kSecondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.monetization_on_outlined,
                                      size: 16,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  TextSpan(
                                      text: " 412 ",
                                      //recognizer: onTapRecognizer,
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  TextSpan(
                                      text: "points",
                                      //recognizer: onTapRecognizer,
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                      ))
                                ]),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "012-3456789",
                          style:
                              TextStyle(color: kSecondaryColor, fontSize: 10),
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
                          style: TextStyle(fontSize: 10, color: kLightGrey),
                        ),
                        Space(5),
                        //View rating start
                        RatingBarIndicator(
                          rating: 2.75,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: kPrimaryColor,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text: "112 ",
                                //recognizer: onTapRecognizer,
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                )),
                            TextSpan(
                                text: "Reviews",
                                //recognizer: onTapRecognizer,
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                ))
                          ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
