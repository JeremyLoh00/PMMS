import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:private_nurse_for_client/constant.dart';
import 'package:private_nurse_for_client/models/nurse/nurse_model.dart';
import 'package:private_nurse_for_client/public_components/space.dart';
import 'package:private_nurse_for_client/public_components/theme_spinner.dart';
import 'package:private_nurse_for_client/theme.dart';

class NurseHistoryItem extends StatelessWidget {
  final NurseModel nurseModel;
  const NurseHistoryItem({
    super.key,
    required this.nurseModel,
  });

  @override
  Widget build(BuildContext context) {
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
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CachedNetworkImage(
                    imageUrl: nurseModel.formalPhoto1Path!,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => ThemeSpinner.spinner(),
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
                  Space(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Icon(
                                  Icons.monetization_on_outlined,
                                  size: 16,
                                  color: kPrimaryColor,
                                ),
                              ),
                              TextSpan(
                                  text: nurseModel.points!.toString(),
                                  //recognizer: onTapRecognizer,
                                  style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                  )),
                              const TextSpan(
                                text: "points",
                                //recognizer: onTapRecognizer,
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          nurseModel.name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    nurseModel.phoneNo!,
                    style: TextStyle(color: kSecondaryColor, fontSize: 10),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
                    style: TextStyle(fontSize: 10, color: kLightGrey),
                    textAlign: TextAlign.justify,
                  ),
                  Space(5),
                  //View rating start
                  RatingBarIndicator(
                    rating: nurseModel.feedbacks!.averageRatings!.toDouble(),
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
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: nurseModel.feedbacks!.reviewCounts!.toString(),
                          //recognizer: onTapRecognizer,
                          style: const TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(
                          text: "Reviews",
                          //recognizer: onTapRecognizer,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Space(5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
